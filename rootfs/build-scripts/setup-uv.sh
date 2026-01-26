#!/bin/sh
# An extremely fast Python package and project manager, written in Rust.
# See: https://docs.astral.sh/uv/
#
# This package is used by Neoovim MCPHub plugin for starting some MCP servers.

echo "Setting-Up uv..."

curl -LsSf https://astral.sh/uv/install.sh | sh
