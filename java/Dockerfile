ARG CERTIFICATE_PASSWORD=123456

FROM likesistemas/exe-sign:latest as sign
ARG CERTIFICATE_PASSWORD
ENV CERT_PASSWORD=${CERTIFICATE_PASSWORD}

FROM maven:3-openjdk-8-slim as jar
WORKDIR /home/app/
COPY java/pom.xml .
RUN mvn -f pom.xml dependency:go-offline -B
COPY java/src src
COPY favicon.ico .
RUN mvn -f pom.xml package
RUN mvn -f pom.xml package

FROM sign as exe-sign
COPY --from=jar /home/app/target/OpenBrowser.exe app.exe
RUN sign

FROM debian:10-slim
WORKDIR /work/
COPY --from=exe-sign /work/app_signed.exe browser.exe
CMD cp -Rfv browser.exe /output/