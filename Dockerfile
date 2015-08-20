FROM debian:jessie

ENV RANGE_START=172.16.42.10
ENV RANGE_END=172.16.42.100
ENV RANGE_NETMASK=255.255.255.0
ENV LEASE_TIME=1h
ENV GATEWAY=172.16.42.1

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    dnsmasq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/dnsmasq

RUN touch /var/lib/dnsmasq/hosts
RUN touch /var/lib/dnsmasq/options

EXPOSE 67/udp
CMD dnsmasq -k -8 - \
    --dhcp-range=$RANGE_START,$RANGE_END,$RANGE_NETMASK,$LEASE_TIME \
    --dhcp-hostsfile=/var/lib/dnsmasq/hosts \
    --dhcp-optsfile=/var/lib/dnsmasq/options \
    --log-dhcp \
    --dhcp-boot=pxelinux.0,pxeserver,$GATEWAY \
    --pxe-service=x86PC,"PXE Booting...",pxelinux
