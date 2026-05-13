<div align="center">
  <img src="assets/dreamx-world_teaser_fig.jpg">

<h1>DreamX-World: A General-Purpose Interactive World Model</h1>

DreamX Team

</div>

<div align="center">

[![Page](https://img.shields.io/badge/%F0%9F%8C%90%20Project%20Page-Demo-00bfff)](https://amap-ml.github.io/DreamX_World)
[![HuggingFace](https://img.shields.io/badge/%F0%9F%A4%97%20Hugging%20Face-Model-yellow)](https://huggingface.co/GD-ML/DreamX-World-5B-Cam)
[![ModelScope](https://img.shields.io/badge/ModelScope-Model-624aff?logo=modelscope)](https://modelscope.cn/models/GD-ML/DreamX-World-5B-Cam)
![Tech Report](https://img.shields.io/static/v1?label=Tech%20Report&message=Coming%20Soon&color=red&logo=arxiv)
[![License](https://img.shields.io/badge/License-Apache--2.0-green)](LICENSE.txt)

</div>

-----

**DreamX-World** is a general-purpose world model for **interactive world simulation**. It generates diverse, high-fidelity worlds that users can explore, control, and transform with event prompts.

The model is trained with a scalable data engine on Unreal Engine data, gameplay footage, and real-world videos, combined with camera estimation and strict data filtering to learn realistic dynamics and interactions. It follows a progressive training pipeline: learning fine-grained action control first, then open-ended event response, and using Reinforcement Learning to improve action following, interaction consistency, and visual fidelity. Finally, through forcing and distillation, DreamX-World achieves efficient inference, making interactive generation practical at scale.

## :fire: News
- 2026.05.11: We open-sourced [DreamX-World-5B-Cam](inference_README.md) and inference codes.

## :calendar: Plan
- :heavy_check_mark: DreamX-World-5B-Cam Model.
- [ ] DreamX-World-14B-Cam Model.
- [ ] Autoregressive Video Generation Model.
- [ ] Audio-Video Joint Generation Model.
- [ ] Real-Time, Interactive, Long-horizon DreamX-World Model.
- [ ] Release Technical Report.

## 🚀 Quick Start
### Setup

1. Install dependencies
```bash
pip install -r requirements.txt
```
2. Download Wan2.2-5B-TI2V checkpoints from https://huggingface.co/Wan-AI

### Inference
To generate videos, run the following script:
```bash
sh inference_5b.sh
```
Please check out [inference_README.md](inference_README.md) for detailed instructions.


## 📍 Checkpoints
| Model | 🤗 Download Link | Details | Instrutions |
| -- | -- | -- | -- |
| DreamX-World-5B-Cam | [Huggingface](https://huggingface.co/GD-ML/DreamX-World-5B-Cam) | w PRoPE Camera Control | [inference_README.md](inference_README.md) |


<!-- ## Inference Speed -->

<!-- ### DreamX-World-5B-Cam
| Hardware | GPUs | DreamX-World-5B-Cam | |
| :--- | :---: | :---: | :---: |
| PPU810e | 1 |  |  |
| PPU810e | 8 |  |  |
| H20 | 8 |  |  | -->


## 🎬 Video Demo
<div align="center">
  <video src="https://www.youtube.com/watch?v=lO_VXzpQehc" width="100%" autoplay muted loop playsinline></video>
  <p><a href="https://www.youtube.com/watch?v=lO_VXzpQehc">Watch on YouTube</a></p>
</div>

### 🌍 Navigate and Explore Realistic Worlds

DreamX-World enables high-fidelity, controllable exploration across diverse realistic environments, including indoor, urban, natural, and architectural scenes.

<table align="center">
  <tr>
    <td><video src="https://github.com/user-attachments/assets/18455751-4712-4966-a35a-bad243622c14" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/d9de84b3-711f-4e69-b839-9d8612736d70" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/afe81308-697f-46f7-9d26-1544319fb345" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/d38d7c03-b827-4ce9-8461-f6ebef697bb9" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
  <tr>
    <td><video src="https://github.com/user-attachments/assets/177bcbb6-0dbe-4cdb-b7e0-8287b6d9ef2c" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/0d5ba9de-cef6-4641-bbe9-1b0fccd6e937" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/1b7e0f95-6b41-423b-85c1-00f4ad91afe1" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/c82a03a0-b66d-433e-978c-fb76a11f8484" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
</table>

### 🌈 Dive into Dream Worlds

Beyond realistic scenes, DreamX-World also generates fantasy, game-like, sci-fi, and stylized worlds.

<table align="center">
  <tr>
    <td><video src="https://github.com/user-attachments/assets/c8bae45b-2644-4e4d-8e46-0323f0b3fbaa" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/72fdff9b-485d-4bd4-a08e-b2c555cabff5" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/0d89e29c-2820-4fe8-b362-69861f62af72" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/8ffa491c-5177-4a81-b198-e4222f56d78c" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
  <tr>
    <td><video src="https://github.com/user-attachments/assets/c93ce1ca-7c5e-4cc3-9255-655ea0d3ad3f" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/49fe7f64-2e16-4c9c-8350-d10a0f1dca88" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/af32cc50-82bf-4005-ae0c-8d350ee31ba3" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/0e2ee2b2-097e-4eec-986c-0dfc9b0d61a5" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
</table>

### 🎮 Generate in Third-Person View

DreamX-World supports both first-person interaction and coherent third-person generation. It keeps camera-follow behavior stable while preserving controllable agent motion and scene consistency.

<table align="center">
  <tr>
    <td><video src="https://github.com/user-attachments/assets/30798a76-859b-4909-bf28-7d0e86a7863b" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/b75223d5-2e35-4071-8a4f-3b3dc94ab01e" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/f01163d0-b3c8-49c8-a058-3a12bf0878e6" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/ad81b04e-25cc-4679-915e-59017b09450d" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
  <tr>
    <td><video src="https://github.com/user-attachments/assets/665b6870-e52e-4dcf-9d0a-ba771557baa8" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/940dc5c7-bcd1-40a3-af82-d5757dd6782b" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/f9f03a78-23ee-4ca2-932c-4d2f972e6f69" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/52659549-0427-4511-802c-f67593feef78" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
</table>

### ⚡ Promptable World Events

DreamX-World supports **prompt-driven world events** that dynamically change the environment, including flexible and compositional event generation with consistent temporal evolution.

- **Single Event**: A single event prompt triggers a specific world-changing interaction.
- **Compositional Events**: Multiple events compose together to create complex, multi-step world transformations.

#### Single Event
<table align="center">
  <tr>
    <td><video src="https://github.com/user-attachments/assets/fb8a22bd-63be-4475-ad08-66a04bec91ae" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/8aa37862-6858-4ad5-98d1-550376ead5c0" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/17173977-9fd7-4dfa-a757-efd6072c488e" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/aeb4cb60-0ee7-42ac-b9c1-7d450d259859" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
</table>

#### Compositional Events
<table align="center">
  <tr>
    <td><video src="https://github.com/user-attachments/assets/3ec93ff5-2ddc-4029-8e32-a90a56ceaeda" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/ceb92937-682f-435b-afd3-30e735c4f5e5" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/d04754ef-ad28-49f9-a48c-15fdc081eecc" width="100%" autoplay muted loop playsinline></video></td>
    <td><video src="https://github.com/user-attachments/assets/63a21964-c19a-489a-9b41-184a110cb60f" width="100%" autoplay muted loop playsinline></video></td>
  </tr>
</table>

## 📜 License

This project is licensed under Apache 2.0. See [LICENSE](LICENSE.txt) for details.

## ✨ Acknowledgement

We thank the Wan Team for open-sourcing their code and models.
