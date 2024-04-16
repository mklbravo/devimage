ARG FROM_IMAGE

FROM ${FROM_IMAGE}

COPY rootfs/ /

RUN chmod +x /build-scripts/* \
    && /build-scripts/bootstrap.sh \
    && rm -rf /build-scripts

ENTRYPOINT ["/init"]
