# aug/12/2023 16:05:04 by RouterOS 6.48.6
# software id = 
#
#
#
/interface bridge
add name=SW-BR vlan-filtering=yes
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=10.0.0.2-10.0.0.254
add name=dhcp_pool1 ranges=192.168.10.2-192.168.10.62
add name=dhcp_pool2 ranges=192.168.20.2-192.168.20.62
add name=dhcp_pool3 ranges=192.168.99.2-192.168.99.254
add name=dhcp_pool4 ranges=192.168.99.2-192.168.99.254
/caps-man manager
set enabled=yes
/interface bridge port
add bridge=SW-BR interface=ether1
add bridge=SW-BR interface=ether2 pvid=10
add bridge=SW-BR interface=ether3 pvid=30
add bridge=SW-BR edge=yes interface=ether4 point-to-point=no
add bridge=SW-BR interface=ether5 pvid=40
add bridge=SW-BR interface=ether6
add bridge=SW-BR interface=ether7
add bridge=SW-BR interface=ether8
add bridge=SW-BR interface=ether9
add bridge=SW-BR interface=ether10
/interface bridge vlan
add bridge=SW-BR tagged=ether1,ether4,ether3 vlan-ids=30
add bridge=SW-BR disabled=yes tagged=ether1,ether2 vlan-ids=10
add bridge=SW-BR disabled=yes tagged=ether1,ether4 vlan-ids=20
add bridge=SW-BR tagged=ether1,ether4,ether5 vlan-ids=40
/ip dhcp-client
add interface=SW-BR
/ip dns
set allow-remote-requests=yes servers=1.1.1.1
/ip route
add distance=1 gateway=172.16.1.1
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh disabled=yes
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/system identity
set name=SW-Core-2
/tool romon
set enabled=yes
