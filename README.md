# Dev Image

A flexible Docker development container image that provides a consistent development environment with pre-installed tools and configurations.

## Building

The project uses a single, parametrized `build` target in the Makefile to support multiple base images. This allows you to create development images for different programming languages and environments.

### Build Command

```bash
make build FROM_IMAGE="<base-image>" TAG="<tag-name>"
```

### Parameters

- `FROM_IMAGE` - The base Docker image to build from (required)
- `TAG` - The tag name for the resulting image (required)

### Examples

```bash
# Build Debian 12 base image
make build FROM_IMAGE="debian:13" TAG="debian-13"

# Build Go 1.25 development image
make build FROM_IMAGE="golang:1.25-trixie" TAG="go-1.25"

# Build PHP 8.3 development image
make build FROM_IMAGE="php:8.3-fpm-trixie" TAG="php-8.3"
```

### What Gets Installed

All images include:

- **Shell**: Zsh with Oh My Zsh, Starship prompt, Tmux, Fuzzy Finder
- **Editor**: Neovim with Lazy plugin manager and Mason language servers
- **Git Tools**: Git, GitHub CLI, Lazygit
- **Development**: Build essentials, Ripgrep, Tree-sitter, Python utilities
- **Coding Agents**: Claude Code, Pi
- **Package Managers**: uv (Python), language-specific package managers
- **MCP Servers**: Context7, Git, GitHub Copilot integration

### Environment Variables

You can customize the Neovim language servers installed by setting the `NVIM_LANGUAGES` environment variable:

```bash
docker run -e NVIM_LANGUAGES="python,rust,go" ghcr.io/mklbravo/devimage:debian-13
```

Multiple languages should be comma-separated without spaces.

### SSH Agent

DevImages use the SSH agent of the host, so your private keys never leave your machine
and you don't need to configure SSH keys inside the container.

Make sure your keys are loaded in the host agent (`ssh-add -l`), mount the agent socket
into the container and point `SSH_AUTH_SOCK` to the mounted path:

**macOS (Docker Desktop)**

```yaml
services:
  dev:
    image: devimage
    environment:
      SSH_AUTH_SOCK: /run/ssh-agent.sock
    volumes:
      - /run/host-services/ssh-auth.sock:/run/ssh-agent.sock
```

**Linux**

```yaml
services:
  dev:
    image: devimage
    environment:
      SSH_AUTH_SOCK: /run/ssh-agent.sock
    volumes:
      - ${SSH_AUTH_SOCK}:/run/ssh-agent.sock
```

With `docker run`, use the same mount and variable, e.g.:

```bash
docker run \
  -v /run/host-services/ssh-auth.sock:/run/ssh-agent.sock \
  -e SSH_AUTH_SOCK=/run/ssh-agent.sock \
  ghcr.io/mklbravo/devimage:debian-13
```
