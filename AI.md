# Install nvidia-container-toolkit

curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo

sudo dnf install -y nvidia-container-toolkit

# Configure podman

sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
nvidia-ctk cdi list

## Test

podman run --rm --device nvidia.com/gpu=all --security-opt=label=disable nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi

podman run \
    -it \
    --rm \
    -p 8384:8384 \
    --device nvidia.com/gpu=all \
    --security-opt=label=disable \
    ghcr.io/ai-dock/comfyui:v2-cuda-12.1.1-base-22.04-v0.2.0


#
podman run \
    -it \
    --rm \
    -p 8501:8501 \
    -e STREAMLIT_SERVER_HEADLESS=true \
    -e "WEBUI_SCRIPT=webui_streamlit.py" \
    -e "VALIDATE_MODELS=false" \
    -v "${PWD}/model_cache:/sd/user_data/" \
    -v "${PWD}/outputs:/sd/outputs" \
    --device nvidia.com/gpu=all \
    --security-opt=label=disable \
    docker.io/tukirito/sygil-webui:latest
