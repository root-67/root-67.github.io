FROM --platform=$BUILDPLATFORM golang:1.27.1-alpine

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

COPY ./build/go-pdns /app/go-pdns

RUN mkdir -p /etc/go-pdns /var/lib/go-pdns

VOLUME ["/etc/go-pdns", "/var/lib/go-pdns"]

EXPOSE 8080

ENTRYPOINT ["/app/go-pdns"]
CMD ["start", "-c", "/etc/go-pdns/"]

LABEL org.opencontainers.image.title="Root-67 PDNS"

