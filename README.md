# docker-dnsmasq

## Usage:

Start the dhcp server:

`docker run -d --name=dhcpd \
    -e RANGE_START=192.168.1.10 \
    -e RANGE_END=192.168.1.50 \
    -v /srv/docker/dnsmasq:/var/lib/dnsmasq:ro \
    sheeprine/docker-dnsmasq:latest`
