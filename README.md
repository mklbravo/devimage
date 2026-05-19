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
- **Package Managers**: uv (Python), language-specific package managers
- **MCP Servers**: Context7, Git, GitHub Copilot integration

### Environment Variables

You can customize the Neovim language servers installed by setting the `NVIM_LANGUAGES` environment variable:

```bash
docker run -e NVIM_LANGUAGES="python,rust,go" ghcr.io/mklbravo/devimage:debian-13
```

Multiple languages should be comma-separated without spaces.

### Secrets

DevImages make some preparations so that you can use secrets in your development environment. 

#### SSH Key

You can define your local SSH to be used inside the container. 
This way you don't need to configure a new SSH key inside the container each time you start the container,
and also you can use it to access your repositories.

To do this you need to define the `ssh_private_key` on your docker-compose.yml file. 

```yaml
secrets:
  ssh_private_key:
    file: ~/.ssh/<your_private_key>
```

Then configure the image based on `devimage` to use this secret.

```yaml
services:
  dev:
    image: devimage
    secrets:
      - ssh_private_key
```
