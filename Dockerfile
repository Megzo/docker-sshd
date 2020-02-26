FROM alpine:3.11.3

RUN apk add --no-cache openssh-server bash
EXPOSE 22

WORKDIR /root
COPY docker-entrypoint.sh ./

ENTRYPOINT [ "./docker-entrypoint.sh" ]