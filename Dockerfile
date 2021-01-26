ARG CERTIFICATE_PASSWORD=123456

FROM golang:alpine as compile
ARG DEFAULT_URL="http://127.0.0.1/"
RUN apk update && apk add --no-cache git
WORKDIR $GOPATH/src/likesistemas/browser/
RUN go get github.com/josephspurrier/goversioninfo/cmd/goversioninfo
COPY main.go favicon.ico versioninfo.json ./
RUN go get -d -v
RUN goversioninfo
RUN go generate
RUN GOOS=windows GOARCH=386 go build -ldflags="-linkmode=internal -w -s -H=windowsgui -X main.url=${DEFAULT_URL}" -o /go/bin/browser-x86.exe
RUN GOOS=windows GOARCH=amd64 go build -ldflags="-linkmode=internal -w -s -H=windowsgui -X main.url=${DEFAULT_URL}" -o /go/bin/browser-x64.exe

FROM likesistemas/exe-sign:latest as sign
ARG CERTIFICATE_PASSWORD
ENV CERT_PASSWORD=${CERTIFICATE_PASSWORD}

FROM sign as sign-x86
COPY --from=compile /go/bin/browser-x86.exe app.exe
RUN sign

FROM sign as sign-x64
COPY --from=compile /go/bin/browser-x64.exe app.exe
RUN sign

FROM debian:10-slim
WORKDIR /work/
COPY --from=sign-x86 /work/app_signed.exe browser-x86.exe
COPY --from=sign-x64 /work/app_signed.exe browser-x64.exe
CMD cp -Rfv *.exe /output/