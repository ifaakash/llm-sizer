FROM nginx:latest

RUN rm -rf /usr/share/nginx/index.html

COPY index.html /usr/share/nginx/index.html

EXPOSE 80
