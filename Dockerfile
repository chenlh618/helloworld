ARG GO_BUILDER_IMAGE=cr-image-cn-beijing.cr.volces.com/clh/golang:1.24
FROM ${GO_BUILDER_IMAGE} AS builder

WORKDIR /src

COPY go.mod ./

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -buildvcs=false -trimpath -ldflags="-s -w" -o /out/helloworld .

FROM scratch

COPY --from=builder /out/helloworld /helloworld

ENTRYPOINT ["/helloworld"]
