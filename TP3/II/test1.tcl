#!/usr/bin/expect

spawn telnet 192.168.68.1 5000
send "\r"
expect "U1>"
send "ping 192.168.110.2\r"
sleep 5
expect "U1>"
send "ping 192.168.120.1\r"
sleep 5
expect "U1>"
send "ping 192.168.130.1\r"
sleep 5
expect "U1>"
send "ping 192.168.140.1\r"
sleep 5
expect "U1>"
send "ping 192.168.150.1\r"
sleep 5
expect "U1>"
send "ping 192.168.160.1\r"
sleep 5
expect "U1>"
send "\x1D"
expect "telnet>"
send "quit\r"
