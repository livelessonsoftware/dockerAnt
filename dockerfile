FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    openjdk-17-jdk \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt


RUN wget https://github.com/ant-media/Ant-Media-Server/releases/download/ams-v2.16.2/ant-media-server-community-2.11.3.zip

RUN wget -O install_ant-media-server.sh https://raw.githubusercontent.com/ant-media/Scripts/master/install_ant-media-server.sh

RUN chmod +x install_ant-media-server.sh

RUN ./install_ant-media-server.sh -i ant-media-server-community-2.16.2.zip

RUN nano /etc/apache/sites-available/antmedia.livelesson.site.conf

RUN a2enmod proxy proxy_http

RUN a2ensite antmedia.livelesson.site.conf

WORKDIR /usr/local/antmedia
RUN ./enable_ssl.sh -d antmedia.livelesson.site
RUN systemctl restart apache2
EXPOSE http://antmedia.livelesson.site:5080
# Download Ant Media Server ZIP
# RUN wget https://github.com/ant-media/Ant-Media-Server/releases/download/ams-v2.16.2/ant-media-server-community-2.16.2.zip

# # Download installer script
# RUN wget -O install_ant-media-server.sh \
#     https://raw.githubusercontent.com/ant-media/Scripts/master/install_ant-media-server.sh \
#     && chmod +x install_ant-media-server.sh

# # Install Ant Media Server
# #RUN ./install_ant-media-server.sh -i ant-media-server-community-2.16.2.zip

# # Cleanup
# RUN rm -f ant-media-server-community-2.16.2.zip install_ant-media-server.sh

# WORKDIR /usr/local/antmedia

# # Expose Ant Media ports
# EXPOSE 5080 5443 1935
# EXPOSE 5000-5005/udp
# EXPOSE 42000-42010/udp

# # Startup script
# COPY start.sh /start.sh
# RUN chmod +x /start.sh

# CMD ["/start.sh"]
