ARG GO_VERSION=1.12.9

FROM golang:${GO_VERSION}-alpine3.9 AS build-env

RUN apk --no-cache add build-base git wget unzip protobuf

WORKDIR /

COPY . .

RUN pwd;ls -alh && go build -o main main.go

FROM alpine:3.9

RUN apk update && apk add tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
    && echo "Asia/Shanghai" > /etc/timezone

RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*

COPY --from=build-env /main /main

EXPOSE 9091

ENTRYPOINT ["/main"]