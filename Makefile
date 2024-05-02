.EXPORT_ALL_VARIABLES:
IMAGE_NAME=ghcr.io/mklbravo/devimage

.PHONY: help
help: ## Displays this list of targets with descriptions
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

build-debian-12: ## Build Debian 12 (bookworm) development image
	docker build --no-cache --force-rm --file Dockerfile --tag $(IMAGE_NAME):debian-12 --build-arg "FROM_IMAGE=debian:12" .

build-go-1.22: ## Build  Go 1.22 development image
	docker build --no-cache --force-rm --file Dockerfile --tag $(IMAGE_NAME):go-1.22 --build-arg "FROM_IMAGE=golang:1.22-bookworm" .

build-node-18: ## Build  Node 18 development image
	docker build --no-cache --force-rm --file Dockerfile --tag $(IMAGE_NAME):node-18 --build-arg "FROM_IMAGE=node:18-bookworm" .

build-rust-1.77: ## Build  Rust 1.77 development image
	docker build --no-cache --force-rm --file Dockerfile --tag $(IMAGE_NAME):rust-1.77 --build-arg "FROM_IMAGE=rust:1.77-bookworm" .

build-php-8.1: ## Build  PHP 8.1 development image
	docker build --no-cache --force-rm --file Dockerfile --tag $(IMAGE_NAME):php-8.1 --build-arg "FROM_IMAGE=php:8.1-fpm-bullseye" .

