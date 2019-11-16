#!/bin/bash

ip link add link ens32 name ens32.10 type vlan id 10
ip link set ens32.10 up
ip addr add 192.168.110.29/27 dev ens32.10

ip link add link ens32 name ens32.20 type vlan id 20
ip link set ens32.20 up
ip addr add 192.168.120.13/28 dev ens32.20

ip link add link ens32 name ens32.40 type vlan id 40
ip link set ens32.40 up
ip addr add 192.168.120.5/29 dev ens32.40

echo 'DHCPDARGS="ens32.10 ens32.20 ens32.40"' > /etc/sysconfig/dhcpd

echo '
# dhcpd.conf

option domain-name "tp3.local";
option domain-name-servers 8.8.8.8, 8.8.4.4;

default-lease-time 3600;
max-lease-time 7200;

authoritative;

log-facility local7;

# Admins
subnet 192.168.140.0 netmask 255.255.255.248 {
        option routers           192.168.140.6;
        option broadcast-address 192.168.140.7;
        range   192.168.140.4    192.168.140.4;
}

# Users
subnet 192.168.110.0 netmask 255.255.255.224 {
        option routers           192.168.110.30;
        option broadcast-address 192.168.110.31;
        range   192.168.110.17   192.168.110.28;
}

# Stagiaires
subnet 192.168.120.0 netmask 255.255.255.240 {
        option routers           192.168.120.14;
        option broadcast-address 192.168.120.15;
        range   192.168.120.9   192.168.120.12;
}

# hide warning
subnet 192.168.150.0 netmask 255.255.255.224 {}
' > /etc/dhcp/dhcpd.conf

systemctl enable --now dhcpd
