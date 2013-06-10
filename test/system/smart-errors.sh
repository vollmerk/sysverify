#!/bin/bash
SMART=`smartctl --scan | awk '{system("smartctl --device=ata -H -q errorsonly " $1)}'`
if [ "${SMART}" == "" ] 
then
	exit 0
else
        echo ${SMART}
	exit 1
fi
