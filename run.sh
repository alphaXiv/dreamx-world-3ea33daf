#!/usr/bin/env bash
# ============================================================================
# DreamX-World 1.0 — minimal single-GPU reproduction
# Runs the released autoregressive (AR-forcing) DreamX-World-5B model:
# camera-controlled, chunk-wise causal image-to-video generation in 4 denoising
# steps. Produces a 5s (81-frame @ 16fps, 704x1280) clip from one image + a
# keyboard-style camera action sequence, then writes evidence to
# .openresearch/artifacts/.
# ============================================================================
set -euo pipefail
cd "$(dirname "$0")"
export HF_HUB_ENABLE_HF_TRANSFER=1
export TOKENIZERS_PARALLELISM=false
ART=.openresearch/artifacts
mkdir -p "$ART"

echo "===== [1/4] Installing dependencies ====="
pip install -q --upgrade pip
pip install -q torch==2.5.1 torchvision==0.20.1
# Single-GPU AR inference does not need xfuser (multi-GPU) or the standalone
# triton/gradio/tensorboard extras; flash-attn is installed separately below.
grep -viE 'flash_attn|xfuser|triton|tensorboard|gradio' requirements.txt > /tmp/reqs.txt
pip install -q -r /tmp/reqs.txt
pip install -q "huggingface_hub[hf_transfer]"

# Cross-attention (WanCrossAttention) calls flash_attention() directly, so a
# real flash-attn build is required. Install the matching prebuilt wheel for the
# active python + torch ABI to avoid a slow/failing source build.
PYTAG=$(python -c "import sys;print(f'cp{sys.version_info.major}{sys.version_info.minor}')")
ABI=$(python -c "import torch;print('TRUE' if torch._C._GLIBCXX_USE_CXX11_ABI else 'FALSE')")
FA_URL="https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.3/flash_attn-2.8.3+cu12torch2.5cxx11abi${ABI}-${PYTAG}-${PYTAG}-linux_x86_64.whl"
echo "Installing flash-attn: $FA_URL"
pip install -q "$FA_URL"
python -c "import flash_attn; print('flash_attn', flash_attn.__version__)"

echo "===== [2/4] Downloading weights ====="
# Wan2.2-TI2V-5B supplies the T5 text encoder, tokenizer and VAE only.
# The 22GB Wan DiT shards are NOT needed: the DreamX AR checkpoint is the full
# transformer (1125 tensors incl. cam_self_attn). Saves ~22GB of download.
python - <<'PY'
from huggingface_hub import snapshot_download
snapshot_download(
    "Wan-AI/Wan2.2-TI2V-5B", local_dir="./Wan2.2-TI2V-5B",
    allow_patterns=["models_t5_umt5-xxl-enc-bf16.pth", "Wan2.2_VAE.pth", "google/umt5-xxl/*"],
)
snapshot_download("GD-ML/DreamX-World-5B", local_dir="./DreamX-World-5B")
print("weights downloaded")
PY

echo "===== [3/4] Preparing minimal input ====="
# One image + a two-segment camera action ("w"=push in, then "wj"=push in + pan
# left). This exercises the paper's core camera-control claim on the cheapest
# released model.
cat > "$ART/eval_min.json" <<'JSON'
[
  {
    "image_path": "./demo/36_Tilt_Down.png",
    "caption": "Style: Photorealistic. A breathtaking coastal landscape captured from a high vantage point, showcasing rugged orange-brown cliffs framing a vibrant turquoise ocean. In the foreground, dry grasses and rocky outcrops lead the eye down into a dramatic cove where powerful waves crash onto the shore, creating frothy white surf. Beyond, the ocean stretches to the horizon under a clear blue sky.",
    "action_seq": ["w", "wj"],
    "action_speed_list": [4, 6]
  }
]
JSON

echo "===== [4/4] Running AR-forcing inference ====="
python inference_ar_forcing.py \
  --config_path configs/dreamx-ar/causal_camera_forcing_5b.yaml \
  --model_name ./Wan2.2-TI2V-5B \
  --transformer_path configs/dreamx-ar/ \
  --checkpoint_path ./DreamX-World-5B \
  --data_path "$ART/eval_min.json" \
  --output_folder "$ART/outputs_ar" \
  --num_output_frames 21 \
  --fps 16 --seed 42 --color_correction_strength 0.3 --chunk_relative

echo "===== Analyzing output ====="
python - <<'PY'
import glob, json, os
import numpy as np
import imageio.v3 as iio

art = ".openresearch/artifacts"
mp4s = sorted(glob.glob(os.path.join(art, "outputs_ar", "*.mp4")))
assert mp4s, "no output video produced"
path = mp4s[0]
vid = iio.imread(path)  # (T, H, W, C)
T, H, W, C = vid.shape
v = vid.astype(np.float32)

# Frame-to-frame mean absolute difference: a non-static, camera-moving scene
# should show clear motion (>> 0). A frozen / collapsed rollout would be ~0.
fd = np.abs(np.diff(v, axis=0)).mean(axis=(1, 2, 3))
# Per-frame brightness drift: large monotone drift = the color-shift failure the
# paper's long-rollout training targets. Report it as a stability proxy.
bright = v.mean(axis=(1, 2, 3))

# Save first / middle / last frames for the report figure.
fdir = os.path.join(art, "frames"); os.makedirs(fdir, exist_ok=True)
for name, i in [("first", 0), ("mid", T // 2), ("last", T - 1)]:
    iio.imwrite(os.path.join(fdir, f"{name}.png"), vid[i])

metrics = {
    "video": os.path.basename(path),
    "frames": int(T), "height": int(H), "width": int(W),
    "mean_frame_diff": round(float(fd.mean()), 4),
    "min_frame_diff": round(float(fd.min()), 4),
    "max_frame_diff": round(float(fd.max()), 4),
    "brightness_first": round(float(bright[0]), 2),
    "brightness_last": round(float(bright[-1]), 2),
    "brightness_drift_abs": round(float(abs(bright[-1] - bright[0])), 2),
}
json.dump(metrics, open(os.path.join(art, "metrics.json"), "w"), indent=2)

lines = [
    "# DreamX-World-5B (AR-forcing) — minimal reproduction",
    "",
    f"- Output video: `{metrics['video']}`",
    f"- Frames: {T}  Resolution: {W}x{H}  FPS: 16  (~{T/16:.1f}s)",
    f"- Denoising steps: 4 (distilled), num_frame_per_block=3, chunk-relative camera",
    f"- Mean frame-to-frame diff (motion proxy, 0-255): {metrics['mean_frame_diff']}",
    f"- Frame-diff range: [{metrics['min_frame_diff']}, {metrics['max_frame_diff']}]",
    f"- Brightness drift first->last: {metrics['brightness_drift_abs']} (lower = less color drift)",
    "",
    "Non-zero, bounded frame-diff with low brightness drift indicates a stable,",
    "moving camera rollout (not a frozen or collapsed generation).",
]
open(os.path.join(art, "EVAL.md"), "w").write("\n".join(lines) + "\n")
print("\n".join(lines))
PY
echo "===== Done. ====="
