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

## Automatic1111

```bash
git clone https://github.com/AbdBarho/stable-diffusion-webui-docker/
cd stable-diffusion-webui-docker/

```


## ComfyUI

```bash
mkdir workspace

podman run \
    -it \
    --rm \
    -p 8188:8188 \
    --device nvidia.com/gpu=all \
    -e WEB_ENABLE_AUTH=false \
    -v "${PWD}/workspace:/workspace" \
    --security-opt=label=disable \
    ghcr.io/ai-dock/comfyui:v2-cuda-12.1.1-base-22.04-v0.2.0
```

# Sygil WebUI

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
