###smartPack dddockerfile
FROM harbor.aipo.lenovo.com/base_env/centos-jdk:v1
MAINTAINER libj6
RUN mkdir -p /home/smartdata/smartPacking/bin/
WORKDIR /home/smartdata/smartPacking/bin/
COPY jvm.options /home/smartdata/smartPacking/bin/
COPY startup.sh /home/smartdata/smartPacking/bin/
RUN chmod +x /home/smartdata/smartPacking/bin/startup.sh
ADD target/conf/ /home/smartdata/smartPacking/conf/
ADD target/lib/ /home/smartdata/smartPacking/lib/
COPY target/smartPack-1.0.0-SNAPSHOT.jar /home/smartdata/smartPacking/

EXPOSE 8080
CMD ["./startup.sh"]