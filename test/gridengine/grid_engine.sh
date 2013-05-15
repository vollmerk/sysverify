#!/bin/bash

# (C) 2012 ACEnet
#
#  Test N1 grid engine  
#       		- notify if sge_execd not running
#


FAILED=0

HOSTNAME="/bin/hostname"
CAT="/bin/cat"
SED="/bin/sed"
GREP="/bin/grep"
WC="/usr/bin/wc -l"
BC="/usr/bin/bc"
LS="/bin/ls"
PS="/bin/ps"

PROC_COUNT=`${PS} -ef | ${GREP} -c sge_exec\[d\]`
if [ ${PROC_COUNT} -ne 1 ] ; then
    echo Node `${HOSTNAME}` sge_execd not running
    FAILED=1
fi

if [ $FAILED -eq 1 ] ; then
    echo " "
    exit 1
fi

exit 0
