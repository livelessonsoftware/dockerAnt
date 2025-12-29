FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install required tools
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Download Ant Media Server
RUN wget https://github.com/ant-media/Ant-Media-Server/releases/download/ams-v2.11.3/ant-media-server-community-2.11.3.zip \
    && unzip ant-media-server-community-2.11.3.zip \
    && mv ant-media-server /usr/local/antmedia \
    && rm ant-media-server-community-2.11.3.zip

EXPOSE 5080 5443 1935
EXPOSE 5000-5005/udp
EXPOSE 42000-42010/udp

CMD ["/usr/local/antmedia/start.sh"]
