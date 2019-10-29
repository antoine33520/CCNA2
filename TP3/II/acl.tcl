#!/usr/bin/expect

spawn telnet 192.168.68.129 5000
send "\r"
send "\r"
expect "#"
send "conf t\r"
expect "(config)#"
send "ip access-list extended admins"
expect "C1(config-ext-nacl)#"
send "remark Admins"
expect "C1(config-ext-nacl)#"
send "1 permit ip 192.168.140.0 0.0.0.7 any"
expect "C1(config-ext-nacl)#"
send "remark Serveurs"
expect "C1(config-ext-nacl)#"
send "2 permit ip 192.168.150.0 0.0.0.7 192.168.140.0 0.0.0.7"
expect "C1(config-ext-nacl)#"
send "remark Serveurs_Sensibles"
expect "C1(config-ext-nacl)#"
send "3 permit ip 192.168.160.0 0.0.0.7 192.168.140.0 0.0.0.7"
expect "C1(config-ext-nacl)#"
send "remark Imprimantes"
expect "C1(config-ext-nacl)#"
send "4 permit ip 192.168.130.0 0.0.0.15 192.168.140.0 0.0.0.7"
expect "C1(config-ext-nacl)#"
send "remark Autres"
expect "C1(config-ext-nacl)#"
send "5 deny ip any 192.168.140.0 0.0.0.7"
expect "C1(config-ext-nacl)#"
send "exit"
expect "(config)#"

send "ip access-list extended users"
expect "C1(config-ext-nacl)#"
ip access-list extended stagiaires
ip access-list extended serveurs
ip access-list extended ss
ip access-list extended imprimantes
