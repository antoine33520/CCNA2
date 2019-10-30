#!/usr/bin/expect

spawn telnet 192.168.68.129 5000
send "\r"
send "\r"
expect "#"
send "conf t\r"
expect "(config)#"
send "ip access-list extended admins\r"
expect "(config-ext-nacl)#"
send "1 permit ip 192.168.140.0 0.0.0.7 any\r"
expect "(config-ext-nacl)#"
send "2 permit ip 192.168.150.0 0.0.0.7 192.168.140.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "3 permit ip 192.168.160.0 0.0.0.7 192.168.140.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "4 permit ip 192.168.130.0 0.0.0.15 192.168.140.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "default deny ip any 192.168.140.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "exit\r"
expect "(config)#"

send "ip access-list extended users\r"
expect "(config-ext-nacl)#"
send "1 permit ip 192.168.110.0 0.0.0.31 any\r"
expect "(config-ext-nacl)#"
send "2 permit ip 192.168.150.0 0.0.0.7 192.168.110.0 0.0.0.31\r"
expect "(config-ext-nacl)#"
send "3 permit ip 192.168.130.0 0.0.0.15 192.168.110.0 0.0.0.31\r"
expect "(config-ext-nacl)#"
send "default deny ip any 192.168.110.0 0.0.0.31\r"
expect "(config-ext-nacl)#"
send "exit\r"
expect "(config)#"

send "ip access-list extended stagiaires\r"
expect "(config-ext-nacl)#"
send "1 permit ip 192.168.120.0 0.0.0.15 any\r"
expect "(config-ext-nacl)#"
send "2 permit ip 192.168.130.0 0.0.0.15 192.168.120.0 0.0.0.15\r"
expect "(config-ext-nacl)#"
send "default deny ip any 192.168.130.0 0.0.0.15\r"
expect "(config-ext-nacl)#"
send "exit\r"
expect "(config)#"

send "ip access-list extended serveurs\r"
expect "(config-ext-nacl)#"
send "1 permit ip 192.168.150.0 0.0.0.7 any\r"
expect "(config-ext-nacl)#"
send "2 permit ip host 192.168.140.1 host 192.168.150.3\r"
expect "(config-ext-nacl)#"
send "3 deny ip any host 192.168.150.3\r"
expect "(config-ext-nacl)#"
send "4 permit ip 192.168.140.0 0.0.0.7 192.168.150.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "5 permit ip 192.168.110.0 0.0.0.31 192.168.150.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "6 permit ip 192.168.130.0 0.0.0.15 192.168.150.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "default deny ip any 92.168.150.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "exit\r"
expect "(config)#"

send "ip access-list extended ss_in\r"
expect "(config-ext-nacl)#"
send "1 permit ip 192.168.160.0 0.0.0.7 192.168.160.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "2 permit ip 192.168.140.0 0.0.0.7 192.168.160.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "default deny ip any 192.168.160.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "exit\r"
expect "(config)#"

send "ip access-list extended ss_out\r"
expect "(config-ext-nacl)#"
send "1 permit ip 192.168.160.0 0.0.0.7 192.168.160.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "2 permit ip 192.168.160.0 0.0.0.7 192.168.140.0 0.0.0.7\r"
expect "(config-ext-nacl)#"
send "default deny ip 192.168.160.0 0.0.0.7 any\r"
expect "(config-ext-nacl)#"
send "exit\r"
expect "(config)#"

send "ip access-list extended imprimantes\r"
expect "(config-ext-nacl)#"
send "permit ip host 192.168.140.3 host 192.168.130.5\r"
expect "(config-ext-nacl)#"

set R3 [list 192.168.110.1 192.168.110.2 192.168.110.3 192.168.110.4 192.168.110.5 192.168.110.6 192.168.120.1 192.168.120.2]
set R4 [list 192.168.110.7 192.168.110.8 192.168.110.9 192.168.110.10 192.168.120.3 192.168.120.4 192.168.120.5 192.168.140.1]
set R5 [list 192.168.140.3 192.168.110.11 192.168.110.12 192.168.110.13 192.168.110.14 192.168.110.15 192.168.110.16 192.168.120.6 192.168.120.7 192.168.120.8]

foreach ip $R3 {
    send "permit ip host $ip host 192.168.130.1\r"
    expect "(config-ext-nacl)#"
}
foreach ip $R4 {
    send "permit ip host $ip host 192.168.130.2\r"
    expect "(config-ext-nacl)#"
}
foreach ip $R5 {
    send "permit ip host $ip host 192.168.130.3\r"
    expect "(config-ext-nacl)#"
foreach int $subint {
    if {$int == 10} {
        set acl users
    } elseif {$int == 20} {
        set acl stagiaires
    } elseif {$int == 30} {
        set acl imprimantes
    } elseif {$int == 40} {
        set acl admins
    } elseif {$int == 50} {
        set acl serveurs
    } elseif {$int == 60} {
        set acl ss_in
    }
    expect "(config)#"
    send "int f0/0.$int\r"
    expect "(config-subif)#"
    send "access-list extended $acl in\r"
    expect "(config-subif)#"
    send "exit\r"
}    send "permit ip host $ip host 192.168.130.4\r"
    expect "(config-ext-nacl)#"
}
expect "(config-ext-nacl)#"
send "default deny ip any any\r"
expect "(config-ext-nacl)#"
send "exit\r"
expect "(config)#"

set subint_in [list 10 20 30 40 50 60]
set acl
foreach int $subint_in {
    if {$int == 10} {
        set acl users
    } elseif {$int == 20} {
        set acl stagiaires
    } elseif {$int == 30} {
        set acl imprimantes
    } elseif {$int == 40} {
        set acl admins
    } elseif {$int == 50} {
        set acl serveurs
    } elseif {$int == 60} {
        set acl ss_in
    }
    expect "(config)#"
    send "int f0/0.$int\r"
    expect "(config-subif)#"
    send "access-list extended $acl in\r"
    expect "(config-subif)#"
    send "exit\r"
}

set subint_out [list 60]
set acl
foreach int $subint_out {
    if {$int == 10} {
        # set acl users
    } elseif {$int == 20} {
        # set acl stagiaires
    } elseif {$int == 30} {
        # set acl imprimantes
    } elseif {$int == 40} {
        # set acl admins
    } elseif {$int == 50} {
        # set acl serveurs
    } elseif {$int == 60} {
        set acl ss_out
    }
    expect "(config)#"
    send "int f0/0.$int\r"
    expect "(config-subif)#"
    send "access-list extended $acl out\r"
    expect "(config-subif)#"
    send "exit\r"
}
