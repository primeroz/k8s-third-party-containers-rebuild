# Build the manager binary
FROM golang:1.13 as builder
ARG URL=https://github.com/nmaupu/vault-secret.git
ARG COMMIT=d0bd8d465f4b124112d41a2aa9aecccc2ca423e2

WORKDIR /workspace

RUN git clone ${URL} . \
    && git reset --hard ${COMMIT}

RUN go mod download

# Build
ARG GOOS
ARG GOARCH
RUN CGO_ENABLED=0 GO111MODULE=on GOOS=${GOOS} GOARCH=${GOARCH} go build -a -o manager main.go

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /workspace/manager .
USER nonroot:nonroot

ENTRYPOINT ["/manager"]
