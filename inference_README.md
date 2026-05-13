# Instructions for using the model

## Parameters
```bash
# ======================== Model Path ========================
MODEL_NAME="./Wan2.2-TI2V-5B"    # Path to the folder containing the Wan2.2-5B-TI2V model weights.
CONFIG_PATH="./configs/wan2.2/wan_ti2v_5b.yaml" # Path to model config file.
TRANSFORMER_PATH="./Dreamx-5b/"  # Path to the folder containing the DreamX model weights.
# ====================== Basic settings ======================
INPUT_DIR="./configs/dreamx/eval.json"          # Json file of inputs, containing image, prompt, and camera control.
OUTPUT_DIR="./outputs/"          # Directory of saving output video.
SAMPLE_HEIGHT=704                # Height of the input image/output video.
SAMPLE_WIDTH=1280                # Width of the input image/output video.
VIDEO_LENGTH=121                 # Number of frames (must satisfy 1+4k pattern). 121 frames for 5-second 24fps video and 81 frames for 5-second 16fps video.
FPS=24                           # FPS of the output video. Supports 24 and 16 FPS.
GUIDANCE_SCALE=3.0               # CFG scale.
NUM_INFERENCE_STEPS=50           # Number of sampling steps.
SEED=42                          # Random seed for noise sampling.

# ====================== Camera Control ======================
CAM_METHOD="prope"               # camera control method
ADD_CONTROL_ADAPTER="--add_control_adapter"

# ======================== Multi-GPU ========================
WEIGHT_DTYPE="bfloat16"          # inference dtype.
ULYSSES_DEGREE=8                 # ulysses degree, 1 for no ulysses.
RING_DEGREE=1                    # ring degree, 1 for no ring.
CUDA_DEVICES="0,1,2,3,4,5,6,7"   # Specify GPUs, e.g., "4,5,6,7". Empty = use all available.
```

## Run inference

### 1. DreamX-World-5B-Cam
- Generates 5-second videos at 24 FPS (121 frames) or 16 FPS (81 frames).
- Supports up to 7.5s (in 16FPS) video generation.

```bash
sh inference_dreamx_5b.sh
```

#### Uncurated Videos (5s, 24 FPS): 
<table align="center">
  <tr>
    <td><video src="https://github.com/user-attachments/assets/9e7362d9-c6ae-465e-8595-fa9c62245f07" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/d6dc8a95-0933-49de-b7ca-4a1284e6ed58" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/bd5301ac-b91d-4898-9da8-8a70e4c69304" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/d35bfdbb-cad7-4627-87d6-a113f82003c7" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
  <tr>
    <td><video src="https://github.com/user-attachments/assets/916c1b06-7799-482e-80f5-948144ee5877" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/89d0ab96-3b19-4896-98db-737087a35007" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/05df0050-7c7e-4338-bd27-22b487bc9479" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/a07ca638-94de-4dd9-9757-ef1ce6f887be" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
</table>

You can reproduce the results by running the model with the provided json file: `configs/dreamx/eval.json`.
