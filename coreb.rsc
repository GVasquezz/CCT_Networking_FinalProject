# aug/12/2023 16:02:10 by RouterOS 6.48.6
# software id = 
#
#
#
/interface ethernet
set [ find default-name=ether1 ] comment=WAN
set [ find default-name=ether2 ] comment=LAN
/interface vrrp
add interface=ether2 name=VRRP preemption-mode=no vrid=50
/interface vlan
add interface=ether4 name=VLAN_10 vlan-id=10
add interface=ether4 name=VLAN_20 vlan-id=20
add interface=ether3 name=VLAN_30 vlan-id=30
add interface=ether3 name=VLAN_40 vlan-id=40
add interface=ether10 name=VLAN_99 vlan-id=99
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=DHCP_POOL_VLAN10 ranges=172.16.0.2-172.16.3.254
add name=DHCP_POOL_VLAN20 ranges=172.16.4.2-172.16.5.254
add name=DHCP_POOL_VLAN30 ranges=172.16.6.2-172.16.6.254
add name=DHCP_POOL_VLAN40 ranges=172.16.7.2-172.16.7.254
add name=dhcp_pool8 ranges=192.168.1.2
/ip dhcp-server
add address-pool=DHCP_POOL_VLAN10 disabled=no interface=VLAN_10 name=\
    DHCP_VLAN10
add address-pool=DHCP_POOL_VLAN20 disabled=no interface=VLAN_20 name=\
    DHCP_VLAN20
add address-pool=DHCP_POOL_VLAN30 disabled=no interface=VLAN_30 name=\
    DHCP_VLAN30
add address-pool=DHCP_POOL_VLAN40 disabled=no interface=VLAN_40 name=\
    DHCP_VLAN40
/ip address
add address=10.0.0.1 interface=VRRP network=10.0.0.1
add address=10.0.0.2/24 interface=ether2 network=10.0.0.0
add address=172.16.0.1/22 comment=MANUFACTURING interface=VLAN_10 network=\
    172.16.0.0
add address=172.16.4.1/23 comment=RESEARCH&DEVELOPMENT interface=VLAN_20 \
    network=172.16.4.0
add address=10.0.0.3/24 interface=ether2 network=10.0.0.0
add address=172.16.6.1/24 comment=SALES/MARKETING interface=VLAN_30 network=\
    172.16.6.0
add address=172.16.7.1/24 comment=IT interface=VLAN_40 network=172.16.7.0
add address=192.168.1.1/30 comment=MGMT interface=VLAN_99 network=192.168.1.0
/ip arp
add address=192.168.40.254 interface=VLAN_40 mac-address=50:00:00:06:00:00
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server network
add address=172.16.0.0/22 dns-server=172.16.7.254,8.8.8.8 gateway=172.16.0.1
add address=172.16.4.0/23 gateway=172.16.4.1
add address=172.16.6.0/24 gateway=172.16.6.1
add address=172.16.7.0/24 gateway=172.16.7.1
/ip firewall address-list
add address=172.16.0.0/22 disabled=yes list=VLAN_10
add address=172.16.4.0/23 disabled=yes list=VLAN_20
/ip firewall nat
add action=masquerade chain=srcnat
/system identity
set name=Core-B
/tool romon
set enabled=yes
