ARG GO_VERSION=1.12.9

FROM haozibi/upx AS build-upx

FROM golang:${GO_VERSION}-alpine3.9 AS build-env

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

COPY --from=build-upx /bin/upx /bin/upx

RUN apk --no-cache add build-base git wget unzip protobuf

WORKDIR /

COPY . .

RUN go build -ldflags "-s -w" -o main main.go

RUN /bin/upx -k --best --ultra-brute main

RUN pwd && ls -alh

FROM alpine:3.9

RUN apk update && apk add tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
    && echo "Asia/Shanghai" > /etc/timezone

RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*

COPY --from=build-env /main /main

RUN ls -alh

EXPOSE 9091

ENTRYPOINT ["/main"]