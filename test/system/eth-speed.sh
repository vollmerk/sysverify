#!/bin/bash
# This checks to make sure we're getting 1000 FD as expected!

INTERFACES=`/sbin/ifconfig -s | sed "1,1d" | awk '{print $1}'`
FAILURE=0

for i in $INTERFACES; do
	if [ $i == "lo" ]
	then
		continue
	fi
	RESULTS=`/usr/sbin/ethtool $i`
	if [[ "$RESULTS" != *"Speed: 1000Mb/s"* ]]; 
	then
		FAILURE=1
		echo "$i Speed not 1000Mb/s"
	fi
	if [[ "$RESULTS" != *"Duplex: Full"* ]]; 
	then
		FAILURE=1
		echo "$i Duplex not Full"
	fi
done

if [ $FAILURE -eq 1 ]
then 
	exit 1
fi

exit 0
