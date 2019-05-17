############################
# STEP 1 build executable binary
############################
FROM golang:1.12-alpine as builder

# Install git + SSL ca certificates.
# Git is required for fetching the dependencies.
# Ca-certificates is required to call HTTPS endpoints.
RUN apk update && apk add --no-cache git ca-certificates tzdata && update-ca-certificates

RUN adduser -D -g '' appuser
WORKDIR $GOPATH/src/dokku-go-dockerfile/

COPY . .

RUN go get -u github.com/golang/dep/cmd/dep && dep ensure

RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/dokku-go-dockerfile .

############################
# STEP 2 build a small image
############################
FROM alpine:latest

COPY --from=builder /etc/passwd /etc/passwd

COPY --from=builder /go/bin/dokku-go-dockerfile /go/bin/dokku-go-dockerfile

USER appuser

ENTRYPOINT ["/go/bin/dokku-go-dockerfile"]