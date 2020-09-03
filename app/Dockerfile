FROM registry.access.redhat.com/ubi8/go-toolset AS builder

RUN mkdir app

ADD . app/

WORKDIR app

RUN GOOS=linux GOARCH=amd64 go build -o ./build/awsome_app hello.go


FROM registry.access.redhat.com/ubi8-minimal
COPY --from=builder /opt/app-root/src/app/build .

USER 1001

CMD ["/awsome_app"]
