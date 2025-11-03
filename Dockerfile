ARG FROM_IMAGE=debian:12

FROM ${FROM_IMAGE}

# Set environment variables for locale
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8
ENV LC_ALL=C.UTF-8

COPY rootfs/ /

RUN chmod +x /build-scripts/* \
    && chmod +x /usr/local/bin/devimage-* \
    && /build-scripts/bootstrap.sh \
    && rm -rf /build-scripts

ENTRYPOINT ["/init"]
