FROM alpine:3.18
WORKDIR /app
RUN wget https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_$(uname -s)_$(uname -m) -O pocketbase
RUN chmod +x pocketbase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:10000"]
