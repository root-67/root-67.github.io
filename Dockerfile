FROM golang:1.27.1 AS builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux \
    go build \
    -ldflags="-s -w -X github.com/root-67/root-67.github.io/internal/version.version=latest" \
    -o go-pdns .

FROM alpine:latest

RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

COPY --from=builder /build/go-pdns /app/go-pdns

RUN mkdir -p /etc/go-pdns /var/lib/go-pdns

VOLUME ["/etc/go-pdns", "/var/lib/go-pdns"]

EXPOSE 8080

ENTRYPOINT ["/app/go-pdns"]
CMD ["start", "-c", "/etc/go-pdns/"]

LABEL org.opencontainers.image.title="Root-67 PDNS"

