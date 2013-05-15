#!/bin/bash

# (C) 2012 ACEnet
#
#  Test uptime - notify if less than 24 hours 
#

UPTIME_MINIMUM=86400
UPTIME="/proc/uptime"
FAILED=0

HOST="/usr/bin/host"
AWK="/bin/awk"
HOSTNAME="/bin/hostname"
CAT="/bin/cat"
GREP="/bin/grep"

SECONDS_UP=`${CAT} ${UPTIME} | ${AWK} -F\. '{print $1}'`
if [ ${SECONDS_UP} -lt ${UPTIME_MINIMUM} ] ; then
   echo Node `${HOSTNAME}` rebooted in last 24 hours
   FAILED=1
fi
if [ $FAILED -eq 1 ] ; then
   exit 1
fi

exit 0
