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

.PHONY: help
help: ## Makefile Help Page
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[\/\%a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-21s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST) 2>/dev/null
