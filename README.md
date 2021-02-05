# Browser

Docker image to generate execulable to open default browser in so.

```docker
docker run -v ${PWD}/output/:/output/ likesistemas/browser:latest # Using java
docker run -v ${PWD}/output/:/output/ likesistemas/browser:latest # Using golang
```

or

```docker
docker-compose up --build
```

## Build Params

CERTIFICATE_PASSWORD: Certificate password. Default: 123456
CERTIFICATE_PASSWORD: Certificate password. Default: 123456

## Multstage Builds

### Using java

```docker
FROM likesistemas/browser:latest

FROM debian:latest
COPY --from=browser /work/browser.exe browser.exe
```

### Using golang

```docker
FROM likesistemas/browser:latest

FROM debian:latest
COPY --from=browser /work/browser-x86.exe browser.exe
COPY --from=browser /work/browser-x64.exe browser.exe
```