ARG FROM_IMAGE=debian:12

#--------------------------------------------------------------------------
# This first stage builds Neovim from source.
# See: https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites
#--------------------------------------------------------------------------
FROM ${FROM_IMAGE} AS nvim-builder

RUN apt-get update && apt-get install --yes --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    gettext \
    git \
    ninja-build && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/neovim/neovim /neovim

WORKDIR /neovim

RUN git checkout stable && \
    make CMAKE_BUILD_TYPE=Release && \
    make install

#--------------------------------------------------------------------------
# Final stage, this will create the final docker image
#--------------------------------------------------------------------------
FROM ${FROM_IMAGE}

# Copy the built Neovim binary from the builder stage
COPY --from=nvim-builder /neovim/build/bin/nvim /usr/local/bin/nvim

# Copy runtime files (optional, but recommended for full functionality)
COPY --from=nvim-builder /neovim/runtime /usr/local/share/nvim/runtime

ENV NVIM_CONFIG_VERSION=1.1.0

# Set environment variables for locale
ENV LANG=C.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=C.UTF-8

COPY rootfs/ /

RUN chmod +x /build-scripts/* \
    && chmod +x /usr/local/bin/devimage-* \
    && /build-scripts/bootstrap.sh \
    && rm -rf /build-scripts

ENTRYPOINT ["/init"]
