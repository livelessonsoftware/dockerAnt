version: "3.8"

services:
  antmedia:
    image: antmedia/ant-media-server:v2.9.1
    container_name: ant-media
    restart: unless-stopped

    environment:
      - SERVER_MODE=standalone
      - AMS_PUBLIC_IP=65.20.109.33
      - JAVA_OPTS=-Xms1g -Xmx2g
      # Enterprise only:
      # - LICENSE_KEY=XXXX-XXXX

    ports:
      - "5080:5080"
      - "1935:1935"
      - "5443:5443"
      - "5554:5554"
      - "40000-65535:40000-65535/udp"

    volumes:
      - antmedia-data:/usr/local/antmedia

volumes:
  antmedia-data:
