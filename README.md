# Browser

Docker image to generate execulable to open default browser in so.

```docker
docker run -v ${PWD}/output/:/output/ likesistemas/browser:latest
```

## Build Params

CERTIFICATE_PASSWORD: Certificate password. Default: 123456

## Multstage Builds

```docker
FROM likesistemas/browser:x86 as browser # FOR x86
FROM likesistemas/browser:x64 as browser # FOR x64

FROM debian:latest
COPY --from=browser /work/app_signed.exe browser.exe
```