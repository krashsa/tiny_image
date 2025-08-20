# ---- Stage 1: Build ----
FROM golang:1.24-alpine AS builder
RUN apk add --no-cache upx
WORKDIR /app
COPY main.go .
COPY go.mod .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o app . \
    && upx --best --lzma app

# ---- Stage 2: Minimal image ----
FROM scratch
COPY --from=builder /app/app /app
EXPOSE 8080
ENTRYPOINT ["/app"]
