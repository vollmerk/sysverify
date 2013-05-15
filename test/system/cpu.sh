#!/bin/bash

# (C) 2012 ACEnet
#
#  Test uptime - notify if less than 24 hours 
#       load average - notify if greater than (number of CPUs + 2)
#

CPUINFO="/proc/cpuinfo"
LOADAVG="/proc/loadavg"
FAILED=0

HOST="/usr/bin/host"
AWK="/bin/awk"
PING="/bin/ping"
HOSTNAME="/bin/hostname"
CAT="/bin/cat"
SED="/bin/sed"
GREP="/bin/grep"
WC="/usr/bin/wc -l"
BC="/usr/bin/bc"
LS="/bin/ls"
PS="/bin/ps"

PROC_COUNT=`${CAT} ${CPUINFO} | ${GREP} processor | ${WC}` 
MAX_LOAD=`echo "(${PROC_COUNT} + 2)" | ${BC}`
LOAD=`${CAT} ${LOADAVG} | ${AWK} -F\. '{print $1}'`
ACTUAL_LOAD=`${CAT} ${LOADAVG} | ${AWK} '{print $1}'`
if [ ${LOAD} -gt ${MAX_LOAD} ] ; then
    echo Node `${HOSTNAME}` has elevated load average: ${ACTUAL_LOAD}
    FAILED=1
fi

if [ $FAILED -eq 1 ] ; then
    exit 1
fi
# This is here because sys verify isn't checking the return code correctly
exit 0
