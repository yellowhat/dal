# AI

## Podman and NVIDIA

```bash
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
    sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
sudo dnf install -y nvidia-container-toolkit
# Configure podman
sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
nvidia-ctk cdi list
# Test
podman run \
    --rm \
    --device nvidia.com/gpu=all \
    --security-opt=label=disable \
    docker.io/nvidia/cuda:12.6.1-base-ubi9 \
    nvidia-smi
```

## ComfyUI

To use custom models copy to `models/checkpoints`:

* SD1.5: `v1-5-pruned-emaonly.ckpt`
* [sd_xl_turbo_1.0_fp16.safetensors](https://huggingface.co/stabilityai/sdxl-turbo/blob/main/sd_xl_turbo_1.0_fp16.safetensors)
* [sd3_medium_incl_clips_t5xxlfp8.safetensors](https://huggingface.co/stabilityai/stable-diffusion-3-medium/blob/main/sd3_medium_incl_clips_t5xxlfp8.safetensors)

To use FLUX1: `Manager` > `Model Manager` > Install `city96/flux1-dev-Q2_K.gguf`

## SwarmUI

By default uses `OfficialStableDiffusion/sd_xl_base_1.0` (VRAM 5.5 GB).

To use SD3-Medium (VRAM 5.5 GB):

1. Login to [stable-diffusion-3-medium](https://huggingface.co/stabilityai/stable-diffusion-3-medium), Accept
2. Download [sd3_medium.safetensors](https://huggingface.co/stabilityai/stable-diffusion-3-medium/resolve/main/sd3_medium.safetensors?download=true) to `Models/Stable-Diffusion`
3. Start SwarmUI > `Generate` > `Models`, click on SD3-Medium icon

To use FLUX1:

1. Start SwarmUI
2. `Utilities` > `Model Downloader`:
    * 24GB [dev]: https://huggingface.co/black-forest-labs/FLUX.1-dev/blob/main/flux1-dev.safetensors
    * 24GB [schenll]: https://huggingface.co/black-forest-labs/FLUX.1-schnell/blob/main/flux1-schnell.safetensors
    * 12GB: https://huggingface.co/lllyasviel/flux1-dev-bnb-nf4/blob/main/flux1-dev-bnb-nf4-v2.safetensors
    * Or copy to `Models/Stable-Diffusion`
3. Start SwarmUI > `Generate` > `Models`, click on `flux1` icon

## AUTOMATIC1111 (deprecated?)

By default uses `sd-v1.5`, (VRAM 2.2 GB).

## Sygil WebUI (deprecated?)

```bash
mkdir user_data
mkdir outputs

podman run \
    -it \
    --rm \
    -p 8501:8501 \
    -e STREAMLIT_SERVER_HEADLESS=true \
    -e "WEBUI_SCRIPT=webui_streamlit.py" \
    -e "VALIDATE_MODELS=false" \
    -v ./user_data:/sd/user_data \
    -v ./outputs:/sd/outputs \
    --device nvidia.com/gpu=all \
    --security-opt=label=disable \
    docker.io/tukirito/sygil-webui:latest
```
