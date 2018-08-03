# aug/02/2018 17:52:08 by RouterOS 6.41
# software id = L25Z-BUUK
#
# model = RouterBOARD mAP L-2nD
# serial number = 65D204E1796B
/interface ethernet
set [ find default-name=ether1 ] name=ether_wan
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=security_master supplicant-identity="" \
    wpa2-pre-shared-key=AAaa-0000
add eap-methods="" management-protection=allowed name=security_guest \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] disabled=no frequency=auto mode=ap-bridge \
    name=wireless_master security-profile=security_master ssid=Master \
    vlan-id=10 vlan-mode=use-tag
/interface vlan
add interface=wireless_master name=vlan_master vlan-id=10
/interface wireless
add disabled=no keepalive-frames=disabled mac-address=4E:5E:0C:14:47:C9 \
    master-interface=wireless_master multicast-buffering=disabled name=\
    wireless_guest security-profile=security_guest ssid=Guest vlan-id=20 \
    vlan-mode=use-tag wds-cost-range=0 wds-default-cost=0 wps-mode=disabled
/interface vlan
add interface=wireless_guest name=vlan_guest vlan-id=20
/ip hotspot
add disabled=no idle-timeout=1m interface=vlan_guest login-timeout=1m name=\
    hots_srv_guest
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/ip pool
add name=pool_master ranges=192.168.10.100-192.168.10.199
add name=pool_guest ranges=172.16.10.100-172.16.10.199
/ip dhcp-server
add address-pool=pool_master disabled=no interface=vlan_master name=\
    dhcp_master
add address-pool=pool_guest disabled=no interface=vlan_guest name=dhcp_guest
/queue simple
add max-limit=64k/1M name=queue_guest target=vlan_guest
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip address
add address=192.168.10.1/24 interface=vlan_master network=192.168.10.0
add address=172.16.10.1/16 interface=vlan_guest network=172.16.0.0
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface=ether_wan
/ip dhcp-server network
add address=172.16.0.0/16 dns-server=172.16.10.1 gateway=172.16.10.1 netmask=\
    16
add address=192.168.10.0/24 dns-server=192.168.10.1 gateway=192.168.10.1 \
    netmask=24
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,8.8.4.4
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat out-interface=ether_wan src-address=\
    192.168.10.0/24
add action=masquerade chain=srcnat out-interface=ether_wan src-address=\
    172.16.10.0/24
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=172.16.0.0/16
/ip hotspot user
add name=admin password=123
add name=guest password=123 server=hots_srv_guest
/system clock
set time-zone-name=Europe/Rome
