ARG FROM_IMAGE

FROM ${FROM_IMAGE}

ENV NVIM_CONFIG_VERSION=0.1.0

COPY rootfs/ /

RUN chmod +x /build-scripts/* \
    && chmod +x /usr/local/bin/devimage-* \
    && /build-scripts/bootstrap.sh \
    && rm -rf /build-scripts

ENTRYPOINT ["/init"]
