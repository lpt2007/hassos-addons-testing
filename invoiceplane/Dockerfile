FROM homeassistant/amd64-base:latest

RUN apk update && \
    apk add --no-cache docker && \
    apk add --no-cache git && \
    git clone https://github.com/InvoicePlane/InvoicePlane.git /var/www/html/invoiceplane && \
    cd /var/www/html/invoiceplane && \
    git checkout tags/v1.5.11 && \
    docker run --rm -it -v $(pwd):/app composer install

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
