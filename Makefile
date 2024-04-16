.PHONY: help
help: ## Displays this list of targets with descriptions
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

build-go-image: ## Build the Go development image
	docker build --force-rm --file Dockerfile --tag devimage:go --build-arg "FROM_IMAGE=golang:1.22-bookworm" .


