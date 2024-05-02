ARG FROM_IMAGE

FROM ${FROM_IMAGE}

COPY rootfs/ /

RUN chmod +x /build-scripts/* \
    && chmod +x /usr/local/bin/devimage-* \
    && /build-scripts/bootstrap.sh \
    && rm -rf /build-scripts

ENTRYPOINT ["/init"]
