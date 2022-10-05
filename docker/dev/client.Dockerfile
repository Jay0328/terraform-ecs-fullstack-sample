FROM nginx:1.23.1

COPY ./dist/apps/client /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
