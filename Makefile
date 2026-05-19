.EXPORT_ALL_VARIABLES:
IMAGE_NAME=ghcr.io/mklbravo/devimage

.PHONY: help
help: ## Display all available targets
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build a development image - Usage: make build FROM_IMAGE="debian:12" TAG="debian-12"
	@if [ -z "$(FROM_IMAGE)" ] || [ -z "$(TAG)" ]; then \
		echo "Error: Both FROM_IMAGE and TAG are required"; \
		echo "Usage: make build FROM_IMAGE=\"<base-image>\" TAG=\"<tag-name>\""; \
		exit 1; \
	fi
	docker build --no-cache --force-rm --file Dockerfile --tag $(IMAGE_NAME):$(TAG) --build-arg "FROM_IMAGE=$(FROM_IMAGE)" .

