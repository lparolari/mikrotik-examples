# aug/03/2018 06:45:37 by RouterOS 6.41
# software id = L25Z-BUUK
#
# model = RouterBOARD mAP L-2nD
# serial number = 65D204E1796B
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=sec_parolari \
    supplicant-identity="" wpa-pre-shared-key=davideluca wpa2-pre-shared-key=\
    davideluca
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n disabled=no frequency=2462 \
    security-profile=sec_parolari ssid=WiFi-Parolari
/ip pool
add name=pool_dhcp_wan ranges=192.168.10.100-192.168.10.199
/ip dhcp-server
add address-pool=pool_dhcp_wan disabled=no interface=ether1 name=dhcp_srv_wan
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip address
add address=192.168.10.1/24 interface=ether1 network=192.168.10.0
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface=wlan1
/ip dhcp-server network
add address=192.168.10.0/24 gateway=192.168.10.1 netmask=24
/ip firewall nat
add action=masquerade chain=srcnat out-interface=wlan1 src-address=\
    192.168.10.0/24
/system clock
set time-zone-name=Europe/Rome
