.EXPORT_ALL_VARIABLES:
IMAGE_NAME=ghcr.io/mklbravo/devimage

.PHONY: help
help: ## Display all available targets
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build a development image - Usage: make build FROM_IMAGE="debian:12" TAG="debian-12"
	@if [ -z "$(FROM_IMAGE)" ] || [ -z "$(TAG)" ]; then \
		echo "Error: Both FROM_IMAGE and TAG are required"; \
		echo "Usage: make build FROM_IMAGE=\"<base-image>\" TAG=\"<tag-name>\""; \
		exit 1; \
	fi
	docker build --no-cache --force-rm --file Dockerfile --tag $(IMAGE_NAME):$(TAG) --build-arg "FROM_IMAGE=$(FROM_IMAGE)" .

.PHONY: build-debian-13
build-debian-13: ## Build Debian 13 image
	$(MAKE) build FROM_IMAGE="debian:13" TAG="debian-13"

.PHONY: build-go-1.26
build-go-1.26: ## Build Go 1.26 image
	$(MAKE) build FROM_IMAGE="golang:1.26-trixie" TAG="go-1.26"

.PHONY: build-php-8.3
build-php-8.3: ## Build PHP 8.3 FPM image
	$(MAKE) build FROM_IMAGE="php:8.3-fpm-trixie" TAG="php-8.3"


build-all-preloaded: ## Build all preloaded images
	$(MAKE) build-debian-13
	$(MAKE) build-go-1.26
	$(MAKE) build-php-8.3
