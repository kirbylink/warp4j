FROM debian:stable-slim
RUN apt-get update && apt-get install -y \
        curl \
        file \
        unzip \
        zip \
    && rm -rf /var/lib/apt/lists/*
RUN curl -s https://github.com/kirbylink/warp4j/raw/branch/master/install.sh | /bin/sh -s
ENTRYPOINT [ "/usr/local/bin/warp4j" ]
