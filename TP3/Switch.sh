#!/bin/bash

telnet 192.168.68.129 5001 <<EOF

conf t

hostname SW1

vlan 10
name net1
exit
vlan 20
name net2
exit
vlan 30
name net3
exit
vlan 40
name netP
exit

interface Ethernet 0/1
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 10,20,30,40
exit

interface Ethernet 0/0
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 20,30,40
exit

interface Ethernet 1/1
switchport mode access
switchport access vlan 10
exit

interface Ethernet 1/2
switchport mode access
switchport access vlan 20
exit

exit
wr
sh int br
EOF

telnet 192.168.68.129 5002 <<EOF

conf t

hostname SW2

vlan 10
name net1
exit
vlan 20
name net2
exit
vlan 30
name net3
exit
vlan 40
name netP
exit

interface Ethernet 0/1
switchport trunk encapsulation dot1q
switchport mode trunk
swichport trunk allowed vlan 10,20,30,40
exit

interface Ethernet 1/0
switchport mode access
switchport access vlan 30
exit

interface Ethernet 1/3
switchport mode access
switchport access vlan 20
exit

interface Ethernet 2/0
switchport mode access
switchport access vlan 40
exit

exit
wr
sh int br
EOF
