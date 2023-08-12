# aug/12/2023 16:03:32 by RouterOS 6.48.6
# software id = 
#
#
#
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=ether1 pvid=10
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3 pvid=20
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5
add bridge=bridge1 interface=ether6
add bridge=bridge1 interface=ether7
add bridge=bridge1 interface=ether8
add bridge=bridge1 interface=ether9
add bridge=bridge1 interface=ether10
/interface bridge vlan
add bridge=bridge1 tagged=ether2,ether4,ether3 vlan-ids=20
add bridge=bridge1 tagged=ether2,ether4,ether1 vlan-ids=10
/ip dhcp-client
add interface=ether1
/system identity
set name=CORE-SW
/tool romon
set enabled=yes
