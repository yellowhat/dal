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

## AUTOMATIC1111

By default uses `sd-v1.5`, (VRAM 2.2 GB).

## ComfyUI

## SwarmUI

By default uses `OfficialStableDiffusion/sd_xl_base_1.0` (VRAM 5.5 GB).

To use SD3-Medium (VRAM 5.5 GB):

1. Login to [stable-diffusion-3-medium](https://huggingface.co/stabilityai/stable-diffusion-3-medium), Accept
2. Download [sd3_medium.safetensors](https://huggingface.co/stabilityai/stable-diffusion-3-medium/resolve/main/sd3_medium.safetensors?download=true) to `Models/Stable-Diffusion`
3. Start SwarmUI > `Generate` > `Models`, click on SD3-Medium icon
4. On the parameters view:
    * "Steps" to 28
    * "CFG scale" to 5

To use FLUX1 (VRAM 8GB is not enought):

1. Start SwarmUI
2. "Utilities" > "Model Downloader":
    * URL: https://huggingface.co/lllyasviel/flux1-dev-bnb-nf4/blob/main/flux1-dev-bnb-nf4-v2.safetensors
3. Start SwarmUI > `Generate` > `Models`, click on `flux1` icon

## Sygil WebUI

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
    -v "${PWD}/user_data:/sd/user_data/" \
    -v "${PWD}/outputs:/sd/outputs" \
    --device nvidia.com/gpu=all \
    --security-opt=label=disable \
    docker.io/tukirito/sygil-webui:latest
```
