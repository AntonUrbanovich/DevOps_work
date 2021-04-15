FROM ubuntu:latest
ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get -y update && apt-get install -y nginx
RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html/ 
COPY 9912.jpg /usr/share/nginx/html/
CMD [ "nginx" ]