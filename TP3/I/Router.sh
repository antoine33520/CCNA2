#!/bin/bash

telnet 192.168.68.129 5003 <<EOF
exit
exit

conf t
interface fastEthernet 0/0.10
encapsulation dot1q 10
ip address 10.3.10.254 255.255.255.0
exit
exit

conf t
interface fastEthernet 0/0.20
encapsulation dot1q 20
ip address 10.3.20.254 255.255.255.0
exit
exit

conf t
interface fastEthernet 0/0.30
encapsulation dot1q 30
ip address 10.3.30.254 255.255.255.0
exit
exit

conf t
interface fastEthernet 0/0.40
encapsulation dot1q 40
ip address 10.3.40.254 255.255.255.0
exit
exit

conf t
interface fastEthernet 0/0
no shut
exit
exit

wr
EOF
