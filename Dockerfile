ARG FROM_IMAGE=debian:12

FROM ${FROM_IMAGE}

ARG TARGETARCH

# Set environment variables for locale
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8
ENV LC_ALL=C.UTF-8

# Socket path where the host SSH agent must be mounted
ENV SSH_AUTH_SOCK=/run/ssh-agent.sock

COPY rootfs/ /

RUN chmod +x /build-scripts/* \
    && chmod +x /usr/local/bin/devimage-* \
    && TARGETARCH="${TARGETARCH}" /build-scripts/bootstrap.sh \
    && rm -rf /build-scripts

ENTRYPOINT ["/init"]
