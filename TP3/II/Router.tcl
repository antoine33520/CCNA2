#!/usr/bin/expect

spawn telnet 192.168.68.129 5000
send "\r"
expect "#"
send "conf t\r"
expect "(config)#"
send "hostname C1\r"
expect "(config)#"
send "int f0/1\r"
expect "(config-if)#"
send "ip add dhcp\r"
expect "(config-if)#"
send "ip nat outside\r"
expect "(config-if)#"
send "no shut\r"
send "exit\r"
expect "(config)#"
send "\r"
send "int f0/0.10\r"
expect "(config-subif)#"
send "encapsulation dot1q 10\r"
expect "(config-subif)#"
send "ip add 192.168.110.30 255.255.255.224\r"
expect "(config-subif)#"
send "ip nat inside\r"
expect "(config-subif)#"
send "ip nat inside source list 1 interface FastEthernet 0/1 overload\r"
expect "(config-subif)#"
send "access-list 1 permit 10.0.0.0 0.255.255.255\r"
expect "(config-subif)#"
send "no shut\r"
expect "(config-subif)#"
send "exit\r"
send "\r"
expect "(config)#"
send "int f0/0.20\r"
expect "(config-subif)#"
send "encapsulation dot1q 20\r"
expect "(config-subif)#"
send "ip add 192.168.120.14 255.255.255.240\r"
expect "(config-subif)#"
send "ip nat inside\r"
expect "(config-subif)#"
send "ip nat inside source list 1 interface FastEthernet 0/1 overload\r"
expect "(config-subif)#"
send "access-list 1 permit 10.0.0.0 0.255.255.255\r"
expect "(config-subif)#"
send "no shut\r"
expect "(config-subif)#"
send "exit\r"
send "\r"
expect "(config)#"
send "int f0/0.30\r"
expect "(config-subif)#"
send "encapsulation dot1q 30\r"
expect "(config-subif)#"
send "ip add 192.168.130.14 255.255.255.240\r"
expect "(config-subif)#"
send "ip nat inside\r"
expect "(config-subif)#"
send "ip nat inside source list 1 interface FastEthernet 0/1 overload\r"
expect "(config-subif)#"
send "access-list 1 permit 10.0.0.0 0.255.255.255\r"
expect "(config-subif)#"
send "no shut\r"
expect "(config-subif)#"
send "exit\r"
send "\r"
expect "(config)#"
send "int f0/0.40\r"
expect "(config-subif)#"
send "encapsulation dot1q 40\r"
expect "(config-subif)#"
send "ip add 192.168.140.6 255.255.255.248\r"
expect "(config-subif)#"
send "ip nat inside\r"
expect "(config-subif)#"
send "ip nat inside source list 1 interface FastEthernet 0/1 overload\r"
expect "(config-subif)#"
send "access-list 1 permit 10.0.0.0 0.255.255.255\r"
expect "(config-subif)#"
send "no shut\r"
expect "(config-subif)#"
send "exit\r"
send "\r"
expect "(config)#"
send "int f0/0.50\r"
expect "(config-subif)#"
send "encapsulation dot1q 50\r"
expect "(config-subif)#"
send "ip add 192.168.150.6 255.255.255.248\r"
expect "(config-subif)#"
send "ip nat inside\r"
expect "(config-subif)#"
send "ip nat inside source list 1 interface FastEthernet 0/1 overload\r"
expect "(config-subif)#"
send "access-list 1 permit 10.0.0.0 0.255.255.255\r"
expect "(config-subif)#"
send "no shut\r"
expect "(config-subif)#"
send "exit\r"
send "\r"
expect "(config)#"
send "int f0/0.60\r"
expect "(config-subif)#"
send "encapsulation dot1q 60\r"
expect "(config-subif)#"
send "ip add 192.168.160.6 255.255.255.248\r"
expect "(config-subif)#"
send "ip nat inside\r"
expect "(config-subif)#"
send "ip nat inside source list 1 interface FastEthernet 0/1 overload\r"
expect "(config-subif)#"
send "access-list 1 permit 10.0.0.0 0.255.255.255\r"
expect "(config-subif)#"
send "no shut\r"
expect "(config-subif)#"
send "exit\r"
send "\r"
expect "(config)#"
send "int f0/0\r"
expect "(config-if)#"
send "no shut\r"
expect "(config-if)#"
send "end\r"
expect "C1#"
send "wr\r"
send "\r"
expect "#"
send "\x1D"
expect "telnet>"
send "quit\r"
