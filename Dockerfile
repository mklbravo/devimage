ARG FROM_IMAGE

FROM ${FROM_IMAGE}

COPY rootfs/ /

RUN chmod +x /scripts/* \
    && /scripts/bootstrap.sh

ENTRYPOINT ["/init"]
