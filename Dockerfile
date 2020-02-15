FROM alpine:latest
RUN apk add bats bash coreutils shellcheck
ADD plugins /opt/plugins
ADD tests /opt/tests
COPY entry-point.sh /opt
RUN chmod 0755 /opt/entry-point.sh && chmod 0755 /opt/plugins/* && chmod 0755 /opt/tests/*
CMD ["bash", "/opt/entry-point.sh"]
