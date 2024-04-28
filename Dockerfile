FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y lua5.3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY generate_gpg_key.lua /usr/src/

WORKDIR /usr/src/

CMD ["lua5.3", "generate_gpg_key.lua"]

