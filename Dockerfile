FROM alpine:latest
RUN apk add bats bash coreutils shellcheck
COPY entry-point.sh /opt
CMD ["bash", "/opt/entry-point.sh"]
