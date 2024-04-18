FROM alpine:3.17.5

EXPOSE 443

ARG DOMAIN_NAME
ARG CERTS

RUN apk update && apk upgrade && apk add --no-cache nginx openssl sed

# SSL Certificate
RUN mkdir -p $CERTS
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout $CERTS/nginx.key \
	-out $CERTS/nginx.crt \
	-subj "/C=DE/ST=Niedersachsen/L=Wolfsburg/O=42Wob/CN=cgodecke"

# nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/nginx.conf \
&&  sed -i "s%CERTS%$CERTS%g" /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
