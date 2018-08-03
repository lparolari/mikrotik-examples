# Exercise

Create a wan connection over eth1; connection is provided by another
devices with dhcp server enabled. This configuration will get the ip
with a dhcp client.

Add two networks over wifi: one for guests and one for offices. For
both network use a vlan with tagged property, but for the guest
network use a /16 class with free access and right bandwidth limits,
while for the other use /24 class with protected access and all
bandwidth.

Then use a nat to allow both wifi networks to navigate on the
internet.
