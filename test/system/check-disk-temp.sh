#!/bin/bash
TEMP=`smartctl --scan | awk '{system("smartctl --device=ata -A " $1)}' | grep Celsius | awk '{print $10}'`
MAXTEMP=30
FAILED=0

for line in ${TEMP}
do
	if [ $line -gt $MAXTEMP ]
	then
		echo "HDD TEMP Warning - ${line}C exceeds ${MAXTEMP}C threshold"
		FAILED=1
	fi
done

if [ $FAILED -eq 1 ]
then
	exit 1
fi

exit 0
