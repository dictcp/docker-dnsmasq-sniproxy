docker-dnsmasq-sniproxy
====
- demo on dnsmasq + sniproxy

Usage
----
remark: `netflix.com` is picked as an example. but it is incomplete for bypass geo-restriction
- start docker containers
```
docker-compose up -d
```
- test dnqmasq overriding
```
➜  docker-dnsmasq-sniproxy host netflix.com 127.0.0.1
Using domain server:
Name: 127.0.0.1
Address: 127.0.0.1#53
Aliases: 

netflix.com has address 127.0.0.1
```
- test sniproxy tunneling/forwarding (without TLS termination)
```
➜  docker-dnsmasq-sniproxy curl -v --resolve netflix.com:443:127.0.0.1 https://netflix.com
* Added   netflix.com:443:127.0.0.1 to DNS cache
* Hostname   netflix.com was found in DNS cache
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to   netflix.com (127.0.0.1) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
```
- set up per-domain resolver overriding on macOS
```
sudo mkdir /etc/resolver
cat 'nameserver 127.0.0.1' > /etc/resolver/netflix.com
```

- test sniproxy tunneling/forwarding (after per-domain resolver overriding on macOS)
```
➜  docker-dnsmasq-sniproxy curl -v https://netflix.com
* Hostname   netflix.com was found in DNS cache
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to   netflix.com (127.0.0.1) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
```
