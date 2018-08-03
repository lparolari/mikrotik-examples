# Execise
Configure the router in order to pick the wifi connection of an
already working access point and use this connection over the eth
interface.

# Example

## Scenario
You have a server, but you cannot connect it to the network throught
wire. However, you must connect it to the network.

## Question
How would you do it?

## Answer
You can take a router with a wlan interface and a eth interface and
configure it in order to pick the network connection from the access
point, using a dhcp client which gets the ip from the network. Than
you must create a security profile matching the existent security
profile of the network.  After that you have only to configure a
network for the eth interface and nat the out interface to the wlan
interface.
