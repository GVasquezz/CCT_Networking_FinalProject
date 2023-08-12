# aug/12/2023 16:06:25 by RouterOS 6.48.6
# software id = 
#
#
#
/interface bridge
add name=SW-BR vlan-filtering=yes
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=SW-BR interface=ether1 pvid=10
add bridge=SW-BR interface=ether4 pvid=10
add bridge=SW-BR disabled=yes interface=ether2
add bridge=SW-BR disabled=yes interface=ether2 pvid=10
add bridge=SW-BR disabled=yes interface=ether3 pvid=10
/interface bridge vlan
add bridge=SW-BR tagged=ether1 untagged=ether4,ether2,ether3 vlan-ids=10
/ip dhcp-client
add interface=ether2
/system identity
set name=SW-A1
/tool romon
set enabled=yes
