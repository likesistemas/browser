# Browser

Docker image to generate execulable to open default browser in so.
By default the executable opens the url http://127.0.0.1/. But you can pass a url by parameter to open the url that is needed.

```bash
docker run -v ${PWD}/output/:/output/ likesistemas/browser:latest # Using java
docker run -v ${PWD}/output/:/output/ likesistemas/browser:latest # Using golang
```

or

```bash
docker-compose up --build
```

## Build Params

- CERTIFICATE_PASSWORD: Certificate password. Default: 123456
- DEFAULT_URL: Default url to be opened. Default: http://127.0.0.1/ # Only support for golang image

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
