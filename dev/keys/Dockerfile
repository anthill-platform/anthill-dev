FROM alpine:3
RUN apk add openssl
WORKDIR /setup
COPY setup.sh /setup
CMD ["/bin/sh", "-c", "/setup/setup.sh"]