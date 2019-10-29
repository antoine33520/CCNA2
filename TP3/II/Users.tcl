#!/usr/bin/expect

set i 0
set gateway 192.168.110.30
set network 110
set mask 27
set m U
set ip_serv 192.168.68.1
set list_port [list 5000 5002 5004 5006 5008 5010 5012 5014 5016 5018 5020 5022 5024 5026 5028 5030]
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
