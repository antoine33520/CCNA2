#!/usr/bin/expect

spawn telnet 192.168.68.129 5006
send "\r"
send "\r"
expect "#"
send "conf t\r"
expect "(config)#"
send "hostname D1\r"
expect "(config)#"
send "vlan 10\r"
expect "(config-vlan)#"
send "name Utilisateurs\r"
send "exit\r"
expect "(config)#"
send "vlan 20\r"
expect "(config-vlan)#"
send "name Stagiaire\r"
send "exit\r"
expect "(config)#"
send "vlan 30\r"
expect "(config-vlan)#"
send "name Imprimantes\r"
send "exit\r"
expect "(config)#"
send "vlan 40\r"
expect "(config-vlan)#"
send "name Administrateurs\r"
send "exit\r"
expect "(config)#"
send "vlan 50\r"
expect "(config-vlan)#"
send "name Serveurs\r"
send "exit\r"
expect "(config)#"
send "vlan 60\r"
expect "(config-vlan)#"
send "name Serveurs-Sensibles\r"
send "exit\r"
expect "(config)#"
send "int e0/0\r"
expect "(config-if)#"
send "switchport trunk encapsulation dot1q\r"
expect "(config-if)#"
send "switchport mode trunk\r"
expect "(config-if)#"
send "switchport trunk allowed vlan 10,20,30,40,50,60\r"
expect "(config-if)#"
send "exit\r"
expect "(config)#"
send "int range e1/1-3\r"
expect "(config-if-range)#"
send "switchport trunk encapsulation dot1q\r"
expect "(config-if-range)#"
send "switchport mode trunk\r"
expect "(config-if-range)#"
send "switchport trunk allowed vlan 10,20,30,40,50,60\r"
expect "(config-if-range)#"
send "exit\r"
expect "(config)#"
send "int range e2/0-1\r"
expect "(config-if-range)#"
send "switchport trunk encapsulation dot1q\r"
expect "(config-if-range)#"
send "switchport mode trunk\r"
expect "(config-if-range)#"
send "switchport trunk allowed vlan 10,20,30,40,50,60\r"
expect "(config-if-range)#"
send "exit\r"
expect "(config)#"
send "exit\r"
expect "#"
send "wr\r"
send "\r"
expect "#"
send "\x1D"
expect "telnet>"
send "quit\r"

set i 0
set ip_serv 192.168.68.129
set list_port [list 5002 5001 5003 5004 5005]
foreach port $list_port {
    set i [expr {$i + 1}]
    spawn telnet $ip_serv $port
    send "\r"
    send "\r"
    expect "#"
    send "conf t\r"
    expect "(config)#"
    send "hostname SW$i\r"
    expect "(config)#"
    send "vlan 10\r"
    expect "(config-vlan)#"
    send "name Utilisateurs\r"
    send "exit\r"
    expect "(config)#"
    send "vlan 20\r"
    expect "(config-vlan)#"
    send "name Stagiaire\r"
    send "exit\r"
    expect "(config)#"
    send "vlan 30\r"
    expect "(config-vlan)#"
    send "name Imprimantes\r"
    send "exit\r"
    expect "(config)#"
    send "vlan 40\r"
    expect "(config-vlan)#"
    send "name Administrateurs\r"
    send "exit\r"
    expect "(config)#"
    send "vlan 50\r"
    expect "(config-vlan)#"
    send "name Serveurs\r"
    send "exit\r"
    expect "(config)#"
    send "vlan 60\r"
    expect "(config-vlan)#"
    send "name Serveurs-Sensibles\r"
    send "exit\r"
    expect "(config)#"
    send "int e0/0\r"
    expect "(config-if)#"
    send "switchport trunk encapsulation dot1q\r"
    expect "(config-if)#"
    send "switchport mode trunk\r"
    expect "(config-if)#"
    send "switchport trunk allowed vlan 10,20,30,40,50,60\r"
    expect "(config-if)#"
    send "exit\r"
    expect "(config)#"

    if { $i == 1} {
        #SW1
        array set var {
            e0/1 40
            e0/2 30
        }
    } elseif { $i == 2 } {
        #SW2
        array set var {
            e1/1 60
            e1/2 50
            e1/3 50
            e2/0 50
            e2/1 50
            e2/2 60
        }
    } elseif { $i == 3 } {
        #SW3
        array set var {
            e0/1 10
            e0/2 10
            e0/3 10
            e1/0 10
            e1/1 10
            e1/2 10
            e1/3 20
            e2/0 20
            e2/1 30
        }
    } elseif { $i == 4 } {
        #SW4
        array set var {
            e0/1 10
            e0/2 10
            e0/3 20
            e1/0 10
            e1/1 10
            e1/2 20
            e1/3 20
            e2/0 40
            e2/1 30
        }
    } elseif { $i == 5 } {
        #SW5
        array set var {
            e0/1 40
            e0/2 10
            e0/3 10
            e1/0 10
            e1/1 10
            e1/2 10
            e1/3 10
            e2/0 20
            e2/1 20
            e2/2 20
            e3/2 30
            e3/3 30
        }
    }
    set start [array startsearch var]
    while {[array anymore var $start]} {
    set int [array nextelement var $start]
        send "int $int\r"
        expect "(config-if)#"
        send "switchport mode access\r"
        expect "(config-if)#"
        send "switchport access vlan "
        send "$var($int)"
        send "\r"
        expect "(config-if)#"
        send "exit\r"
    }
    array donesearch var $start

    send "exit\r"
    expect "#"
    send "wr\r"
    send "\r"
    expect "#"
    send "\x1D"
    expect "telnet>"
    send "quit\r"
}
