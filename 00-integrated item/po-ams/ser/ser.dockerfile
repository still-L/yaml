FROM harbor.aipo.lenovo.com/base_env/alpine_java:8
MAINTAINER libj6
WORKDIR /
COPY target/assert-manage-admin-0.0.1-SNAPSHOT.jar /ams.jar
EXPOSE 80
ENTRYPOINT ["java","-jar","ams.jar","--server.port=80"]