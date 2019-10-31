#!/usr/bin/expect

spawn telnet 192.168.68.129 5000
send "\r"
send "\r"
expect "#"
send "conf t\r"
expect "(config)#"

send "exit\r"
expect "#"
send "wr\r"
send "\r"
expect "#"
send "\x1D"
expect "telnet>"
send "quit\r"
