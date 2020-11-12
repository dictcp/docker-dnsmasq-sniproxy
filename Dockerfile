FROM debian

RUN apt update && \
    apt -y install sniproxy dnsmasq net-tools busybox


