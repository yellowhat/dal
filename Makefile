MAKEFLAGS     += --no-print-directory
MKFILE_DIR    := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
.DEFAULT_GOAL := help

.PHONY: download
download: ## Download
	podman build -t download:local download
	mkdir -p data
	podman run \
		--interactive \
		--tty \
		--rm \
		--volume "./data:/data:z" \
		download:local

.PHONY: auto
auto: ## Start AUTOMATIC1111 Web UI
	podman build -t automatic:local AUTOMATIC1111
	mkdir -p output
	podman run \
		--interactive \
		--tty \
		--rm \
		--device nvidia.com/gpu=all \
		--publish 8080:7860 \
		--env CLI_ARGS="--allow-code --medvram --xformers --enable-insecure-extension-access --api" \
		--volume "./data:/data:z" \
		--volume "./output:/output:z" \
		--security-opt=label=disable \
		automatic:local

.PHONY: comfyui
comfyui: ## Start ComfyUI
	mkdir -p workspace models
	podman run \
		--interactive \
		--tty \
		--rm \
		--device nvidia.com/gpu=all \
		--publish 8080:8188 \
		--env WEB_ENABLE_AUTH=false \
		--volume ./workspace:/workspace:z \
		--volume ./models:/opt/ComfyUI/models:z \
		--security-opt=label=disable \
		ghcr.io/ai-dock/comfyui:v2-cuda-12.1.1-base-22.04-v0.2.0

.PHONY: swarmui
swarmui: ## Start SwarmUI
	rm -rf SwarmUI
	git clone https://github.com/mcmonkeyprojects/SwarmUI.git --depth 1
	podman build -t swarmui:local SwarmUI
	mkdir -p \
		Data \
		dlbackend \
		Models \
		Output \
		CustomWorkflows
	podman run \
		--interactive \
		--tty \
		--rm \
		--device nvidia.com/gpu=all \
		--publish 8080:7801 \
		--volume ./Data:/Data:z \
		--volume ./dlbackend:/dlbackend:z \
		--volume ./Models:/Models:z \
		--volume ./Output:/Output:z \
		--volume ./CustomWorkflows:/src/BuiltinExtensions/ComfyUIBackend/CustomWorkflows:z \
		--security-opt=label=disable \
		swarmui:local

.PHONY: help
help: ## Makefile Help Page
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[\/\%a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-21s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST) 2>/dev/null
