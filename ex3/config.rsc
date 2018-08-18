# aug/13/2018 11:05:19 by RouterOS 6.41
# software id = L25Z-BUUK
#
# model = RouterBOARD mAP L-2nD
# serial number = 65D204E1796B
/interface wireless
set [ find default-name=wlan1 ] frequency=auto mode=ap-bridge ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/ip pool
add name=pool1 ranges=192.168.10.100-192.168.10.199
add name=pool2 ranges=192.168.20.100-192.168.20.199
/ip dhcp-server
add address-pool=pool1 disabled=no interface=ether1 name=server1
add address-pool=pool2 disabled=no interface=wlan1 name=server2
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip address
add address=192.168.10.1/24 interface=ether1 network=192.168.10.0
add address=192.168.20.1/24 interface=wlan1 network=192.168.20.0
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=192.168.10.1 gateway=192.168.10.1 \
    netmask=24
add address=192.168.20.0/24 dns-server=192.168.20.1 gateway=192.168.20.1 \
    netmask=24
/ip firewall filter
add action=drop chain=forward comment="FORWARD_CHAIN (do not enable)" \
    disabled=yes
add action=accept chain=forward comment=accept_199_to199 dst-address=\
    192.168.10.199 src-address=192.168.20.199
add action=drop chain=forward comment=drop_lan_to_lan7 dst-address=\
    192.168.10.0/24 src-address=192.168.20.0/24
add action=drop chain=forward dst-address=192.168.20.0/24 src-address=\
    192.168.10.0/24
add action=drop chain=forward comment=drop_boggon_ip src-address=0.0.0.0/8
add action=drop chain=forward dst-address=0.0.0.0/8
add action=drop chain=forward src-address=127.0.0.0/8
add action=drop chain=forward dst-address=127.0.0.0/8
add action=drop chain=forward src-address=224.0.0.0/3
add action=drop chain=forward dst-address=224.0.0.0/3
add action=drop chain=input comment="INPUT_CHAIN (do not enable)" disabled=\
    yes
add action=accept chain=input comment=accept_trusted in-interface=!ether1 \
    src-address=192.168.0.0/24
add action=drop chain=input comment=drop_invalid_connections \
    connection-state=invalid
add action=drop chain=input comment=drop_dhcp_relay dst-port=53 protocol=udp \
    src-port=""
add action=accept chain=input comment=accept_known_connections \
    connection-state=established,related
add action=accept chain=input comment=accept_mikrotik_connections dst-port=\
    58291 protocol=tcp
add action=drop chain=input comment=drop_everything_else
add action=drop chain=output comment="OUTPUT_CHAIN (do not enable)" disabled=\
    yes
add action=accept chain=output comment=accept_everything
add action=drop chain=tcp comment="TCP_CHAIN (do not enable)" disabled=yes
add action=drop chain=tcp comment=drop_tftp dst-port=69 protocol=tcp
add action=drop chain=tcp comment=drop_rpc_portmapper dst-port=111 protocol=\
    tcp
add action=drop chain=tcp dst-port=135 protocol=tcp
add action=drop chain=tcp comment=drop_netbios dst-port=137-139 protocol=tcp
add action=drop chain=tcp comment=drop_cifs dst-port=445 protocol=tcp
add action=drop chain=tcp comment=drop_nfs dst-port=2049 protocol=tcp
add action=drop chain=tcp comment=drop_netbus dst-port=12345-12346 protocol=\
    tcp
add action=drop chain=tcp dst-port=20034 protocol=tcp
add action=drop chain=tcp comment=drop_backoriffice dst-port=3133 protocol=\
    tcp
add action=drop chain=udp comment="UDP_CHAIN (do not enable)" disabled=yes
add action=drop chain=udp comment=drop_tftp dst-port=69 protocol=udp
add action=drop chain=udp comment=drop_prc_portmapper dst-port=111 protocol=\
    udp
add action=drop chain=udp comment=drop_prc_portmapper dst-port=135 protocol=\
    udp
add action=drop chain=udp comment=drop_nbt dst-port=137-139 protocol=udp
add action=drop chain=udp comment=drop_nfs dst-port=2049 protocol=udp
add action=drop chain=udp comment=drop_backoriffice dst-port=3133 protocol=\
    udp
add action=drop chain=icmp comment="ICMP_CHAIN (do not enable)" disabled=yes
add action=accept chain=icmp comment=accept_icmp_echo_replay icmp-options=0:0 \
    protocol=icmp
add action=accept chain=icmp comment=accept_icmp_net_unreachable \
    icmp-options=3:0 protocol=icmp
add action=accept chain=icmp comment=accept_icmp_host_unreachable \
    icmp-options=3:1 protocol=icmp
add action=accept chain=icmp comment=\
    accept_icmp_host_unreachable_fragmentation_required icmp-options=3:4 \
    protocol=icmp
add action=accept chain=icmp comment=accept_icmp_source_quench icmp-options=\
    4:0 protocol=icmp
add action=accept chain=icmp comment=accept_icmp_echo_request icmp-options=\
    8:0 protocol=icmp
add action=accept chain=icmp comment=accept_icmp_time_exceed icmp-options=\
    11:0 protocol=icmp
add action=accept chain=icmp comment=accept_icmp_parameter_bad icmp-options=\
    12:0 protocol=icmp
add action=drop chain=icmp comment=drop_everything_else
/ip firewall nat
add action=masquerade chain=srcnat disabled=yes dst-port=58291 protocol=tcp
/ip service
set winbox port=58291
/snmp
set contact=test enabled=yes location=Luca trap-generators=start-trap \
    trap-interfaces=all
/system clock
set time-zone-name=Europe/Rome
