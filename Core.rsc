# aug/12/2023 15:58:52 by RouterOS 6.48.1
# software id = 
#
#
#
/interface ethernet
set [ find default-name=ether1 ] comment=WAN
/interface vrrp
add interface=ether2 name=VRRP priority=200 vrid=50
/interface vlan
add interface=ether3 name=VLAN_10 vlan-id=10
add interface=ether3 name=VLAN_20 vlan-id=20
add interface=ether4 name=VLAN_30 vlan-id=30
add interface=ether4 name=VLAN_40 vlan-id=40
add interface=ether10 name=VLAN_99 vlan-id=99
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=DHCP_POOL_VLAN10 ranges=172.16.0.2-172.16.3.254
add name=DHCP_POOL_VLAN20 ranges=172.16.4.2-172.16.5.254
add name=DHCP_POOL_VLAN30 ranges=172.16.6.2-172.16.6.254
add name=DHCP_POOL_VLAN40 ranges=172.16.7.2-172.16.7.254
add name=dhcp_pool8 ranges=192.168.1.2
add name=VPN_POOL ranges=172.16.8.2-172.16.8.254
/ip dhcp-server
add address-pool=DHCP_POOL_VLAN10 disabled=no interface=VLAN_10 name=\
    DHCP_VLAN10
add address-pool=DHCP_POOL_VLAN20 disabled=no interface=VLAN_20 name=\
    DHCP_VLAN20
add address-pool=DHCP_POOL_VLAN30 disabled=no interface=VLAN_30 name=\
    DHCP_VLAN30
add address-pool=DHCP_POOL_VLAN40 disabled=no interface=VLAN_40 name=\
    DHCP_VLAN40
/ppp profile
set *0 local-address=172.16.4.1 remote-address=VPN_POOL
/interface l2tp-server server
set authentication=mschap2 default-profile=default enabled=yes ipsec-secret=\
    123456 keepalive-timeout=disabled use-ipsec=required
/ip address
add address=172.16.0.1/22 comment=MANUFACTURING interface=VLAN_10 network=\
    172.16.0.0
add address=172.16.4.1/23 comment=RESEARCH&DEVELOPMENT interface=VLAN_20 \
    network=172.16.4.0
add address=10.0.0.1 comment="High Aviability" interface=VRRP network=\
    10.0.0.1
add address=10.0.0.3/24 interface=ether2 network=10.0.0.0
add address=172.16.6.1/24 comment=SALES/MARKETING interface=VLAN_30 network=\
    172.16.6.0
add address=172.16.7.1/24 comment=IT interface=VLAN_40 network=172.16.7.0
add address=192.168.1.1/30 comment=MGMT interface=VLAN_99 network=192.168.1.0
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server network
add address=172.16.0.0/22 dns-server=172.16.7.254,8.8.8.8 gateway=172.16.0.1
add address=172.16.4.0/23 dns-server=172.16.7.254,8.8.8.8 gateway=172.16.4.1
add address=172.16.6.0/24 dns-server=172.16.7.254,8.8.8.8 gateway=172.16.6.1
add address=172.16.7.0/24 dns-server=172.16.7.254,8.8.8.8 gateway=172.16.7.1
/ip dns
set servers=1.1.1.1
/ip firewall address-list
add address=172.16.0.0/22 list=VLAN_10_SECURE
add address=172.16.4.0/23 list=VLAN_20_SECURE
add address=172.16.6.0/24 list=VLAN_30_SECURE
add address=172.16.7.0/24 list=VLAN_40_SECURE
/ip firewall filter
add action=drop chain=forward comment=ACL disabled=yes dst-address-list=\
    VLAN_20 src-address-list=VLAN_10
add action=accept chain=forward disabled=yes in-interface=ether1 protocol=\
    l2tp src-address=192.168.245.0/24
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/ppp secret
add local-address=172.16.4.1 name=haleon password=123456 remote-address=\
    172.16.8.3 service=l2tp
/system identity
set name=Dungarvan-OTC-Core-R
/tool romon
set enabled=yes
