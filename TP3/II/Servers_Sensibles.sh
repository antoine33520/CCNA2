#!/usr/bin/expect

spawn telnet 192.168.68.1 5064
send "\r"
expect ">"
send "set pcname SRV1\r"
expect ">"
send "ip 192.168.160.1/29 192.168.160.6\r"
expect "SRV1>"
send "save\r"
expect "SRV1>"
send "\x1D"
expect "telnet>"
send "quit"

spawn telnet 192.168.68.1 5074
send "\r"
expect ">"
send "set pcname SRV6\r"
expect ">"
send "ip 192.168.160.2/29 192.168.160.6\r"
expect "SRV6>"
send "save\r"
expect "SRV6>"
send "\x1D"
expect "telnet>"
send "quit"
