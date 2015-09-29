#!/usr/bin/env sh

pipework --wait
exec dnsmasq -k -8 - \
    --interface=eth1 \
    --addn-hosts=/var/lib/dnsmasq/dnshosts \
    --dhcp-range=$RANGE_START,$RANGE_END,$RANGE_NETMASK,$LEASE_TIME \
    --dhcp-hostsfile=/var/lib/dnsmasq/hosts \
    --dhcp-optsfile=/var/lib/dnsmasq/options \
    --log-dhcp \
    --dhcp-boot=pxelinux.0 \
    --pxe-service=x86PC,"PXE Booting...",pxelinux \
    --pxe-service=BC_EFI,"UEFI PXE Booting...",syslinux.efi \
    --enable-tftp \
    --tftp-root=/var/lib/tftpboot \
    --tftp-no-blocksize \
    --tftp-lowercase
