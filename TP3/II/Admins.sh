#!/usr/bin/expect

set i 0
set gateway 192.168.140.6
set network 140
set mask 29
set m A
set ip_serv 192.168.68.1
set list_port [list 5058 5060 5062]
foreach port $list_port {
    set i [expr {$i + 1}]
    spawn telnet $ip_serv $port
    send "\r"
    expect ">"
    send "set pcname $m$i\r"
    expect ">"
    send "ip 192.168.$network.$i/$mask $gateway\r"
    expect ">"
    send "save\r"
    expect "$m$i>"
    send "\x1D"
    expect "telnet>"
    send "quit"
}
