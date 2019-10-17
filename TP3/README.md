# TP3

## I. Router-on-a-stick

**Schéma :**

``` ascii
             +--+
             |R1|
             +-++
               |
               |                    +---+
               |          +---------+PC4|
+---+        +-+-+      +---+       +---+
|PC1+--------+SW1+------+SW2|
+---+        +-+-+      +-+--+
               |          |  |
               |          |  +------+--+
               |          |         |P1|
             +-+-+      +-+-+       +--+
             |PC2|      |PC3|
             +---+      +---+
```

**Tableau des réseaux utilisés :**

Réseau | Adresse | VLAN | Description
--- | --- | --- | ---
`net1` | `10.3.10.0/24` | 10 | Utilisateurs
`net2` | `10.3.20.0/24` | 20 | Admins
`net3` | `10.3.30.0/24` | 30 | Visiteurs
`netP` | `10.3.40.0/24` | 40 | Imprimantes

**Tableau d'adressage :**

Machine | VLAN | IP `net1` | IP `net2` | IP `net3` |  IP `netP`
--- | --- | --- | --- | --- | ---
PC1 | 10 | `10.3.10.1/24` | x | x | x
PC2 | 20 | x | `10.3.20.2/24` | x | x | x
PC3 | 30 | x | `10.3.20.3/24` | x | x | x
PC4 | 30 | x | x |  `10.3.30.4/24` | x | x
P1 | 40 | x | x | x | `10.3.40.1/24`
R1 | x |  `10.3.10.254/24` | `10.3.20.254/24` | `10.3.30.254/24` | `10.3.40.254/24`

### Configuration des clients et de l'imprimantes

[script de configuration](./VPCS.sh)

### Configuration du routeur

[script de configuration](./Router.sh)

### Configuration du switch

[script de configuration](./Switch.sh)

### Vérification

Il suffit de faire quelques pings afin de vérifier que les machines communiques ou non.

```cisco
PC2> ping 10.3.30.4 #PC4
84 bytes from 10.3.30.4 icmp_seq=1 ttl=63 time=14.649 ms
84 bytes from 10.3.30.4 icmp_seq=2 ttl=63 time=11.402 ms
84 bytes from 10.3.30.4 icmp_seq=3 ttl=63 time=13.629 ms
84 bytes from 10.3.30.4 icmp_seq=4 ttl=63 time=13.996 ms
^C
PC2> ping 10.3.10.1 #PC1
10.3.10.1 icmp_seq=1 timeout
10.3.10.1 icmp_seq=2 timeout
10.3.10.1 icmp_seq=3 timeout
10.3.10.1 icmp_seq=4 timeout
10.3.10.1 icmp_seq=5 timeout

```
