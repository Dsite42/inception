FROM alpine:3.18.6

# The container listens on port 443, the standard port for HTTPS traffic.
EXPOSE 443

# Defines build-time variables that will be passed to Docker during the build process.
ARG DOMAIN_NAME
ARG CERTS

RUN apk update && apk upgrade && apk add --no-cache nginx openssl sed

# SSL Certificate
RUN mkdir -p $CERTS
# Generates a new self-signed X.509 certificate with a new RSA key of 2048 bits.
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout $CERTS/nginx.key \
	-out $CERTS/nginx.crt \
	-subj "/C=DE/ST=Niedersachsen/L=Wolfsburg/O=42Wolfsburg/CN=cgodecke"

# nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Replace placeholders in the Nginx configuration file with the actual values of DOMAIN_NAME and CERTS. 
RUN sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/nginx.conf \
&&  sed -i "s%CERTS%$CERTS%g" /etc/nginx/nginx.conf

# Start Nginx with the global directive daemon off. (This keeps Nginx running in the foreground)
CMD ["nginx", "-g", "daemon off;"]
