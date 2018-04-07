#!/bin/bash
echo "start"
for((i=1; i<172; i++))
do
v=$(/sbin/route add -net "$i".0.0.0 netmask 255.0.0.0 gw 182.92.123.247 dev eth1) #182.92.123.247 is the gateway address of your Virtual-Machine server.
echo "$v"
done

for((i=173; i<256; i++))
do
v=$(/sbin/route add -net "$i".0.0.0 netmask 255.0.0.0 gw 182.92.123.247 dev eth1)
echo "$v"
done

/sbin/route add -net 172.0.0.0 netmask 255.0.0.0 gw 1.1.1.1 dev tun0 #let 172.0.0.0 route to vpn channel.
/sbin/route del default #delete default route,we have add all route manually just before.
echo "finished"

v=$(/sbin/route)

echo "$v"
