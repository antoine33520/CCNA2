#!/usr/bin/expect

set ip 0
set i 1
set gateway 192.168.150.6
set network 150
set mask 29
set m SRV
set ip_serv 192.168.68.1
set list_port [list 5066 5068 5070 5072]
foreach port $list_port {
    set i [expr {$i + 1}]
    set ip [expr {$ip + 1}]
    spawn telnet $ip_serv $port
    send "\r"
    expect ">"
    send "set pcname $m$i\r"
    expect ">"
    send "ip 192.168.$network.$ip/$mask $gateway\r"
    expect ">"
    send "save\r"
    expect "$m$i>"
    send "\x1D"
    expect "telnet>"
    send "quit"
}

