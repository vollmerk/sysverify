#!/bin/bash

# (C) 2012 ACEnet
#
#  Test NTP - notify if ntw not sync'd with the head node
#


FAILED=0

HOSTNAME="/bin/hostname"
GREP="/bin/grep"
WC="/usr/bin/wc -l"
NTPQ="/usr/sbin/ntpq"

# don't check for '\*clhead' bcs some sites sync elsewhere too
# - also therefore exclude sync to local clock as being in sync
TIME_SYNC=`${NTPQ} -p | ${GREP} -v LOCAL | ${GREP} \* | ${WC} `
if [ ${TIME_SYNC} -ne 1 ] ; then
    echo Node `${HOSTNAME}` has lost time sync
    ntpq -p | sed "1,2d"
    FAILED=1
fi

if [ $FAILED -eq 1 ] ; then
    exit 1
fi

exit 0

