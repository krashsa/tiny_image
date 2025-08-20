# tiny_image
Конкурс ГНИВЦ
## Язык и версия компилятора:
golang 1.24
## Dockerfile:
#---- Stage 1: Build ----
FROM golang:1.24-alpine AS builder
RUN apk add --no-cache upx
WORKDIR /app
COPY main.go go.mod .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o app . \
    && upx --best --lzma app

#---- Stage 2: Minimal image ----
FROM scratch
COPY --from=builder /app/app /app
EXPOSE 8080
ENTRYPOINT ["/app"]

## инструкция

docker build -t tiny-image:v..1 . && docker run -p 8080:8080 tiny-image:v.1

## ссылка на registry
https://hub.docker.com/r/krashsa/tiny-image


