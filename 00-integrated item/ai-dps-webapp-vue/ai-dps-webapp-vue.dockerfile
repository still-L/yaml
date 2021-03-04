FROM harbor.aipo.lenovo.com/smartworkplace/smartworkplace_web:12
MAINTAINER libj6
COPY nginx.conf /etc/nginx/conf.d/webapp.nginx.conf
COPY dist/ /web/dist
WORKDIR /web/dist
EXPOSE 80