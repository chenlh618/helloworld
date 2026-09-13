FROM golang:1.24 AS builder

WORKDIR /src

COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -buildvcs=false -trimpath -ldflags="-s -w" -o /out/helloworld .

FROM gcr.io/distroless/static-debian12:nonroot

COPY --from=builder /out/helloworld /helloworld

USER nonroot:nonroot
ENTRYPOINT ["/helloworld"]
