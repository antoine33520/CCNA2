#!/usr/bin/expect

set i 0
set gateway 192.168.130.14
set network 130
set mask 28
set m P
set ip_serv 192.168.68.1
set list_port [list 5048 5050 5052 5054 5056]
foreach port $list_port {
    set i [expr {$i + 1}]
    spawn telnet $ip_serv $port
    send "\r"
    expect ">"
    send "ip 192.168.$network.$i/$mask $gateway\r"
    expect ">"
    send "set pcname $m$i\r"
    expect ">"
    send "save\r"
    expect "$m$i>"
    send "\x1D"
    expect "telnet>"
    send "quit"
}
