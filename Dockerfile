FROM alpine:3.18
WORKDIR /app

RUN apk add --no-cache wget unzip bash

ENV PB_VERSION=0.21.2
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x pocketbase

VOLUME /app/pb_data
RUN mkdir -p /app/pb_data

# 🔴 追加する部分
COPY pb_public /app/pb_public

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

RUN chmod -R 777 /app

CMD ["sh", "/app/start.sh"]
