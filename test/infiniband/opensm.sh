#!/bin/bash

FAILED=0
HOSTNAME=`hostname`

OPENSM=`/etc/init.d/opensm status | grep "is running" | wc -l`
if [ ${OPENSM} -lt 1 ] ; then
    echo OPENSM not running on ${HOSTNAME}
    FAILED=1
fi

if [ $FAILED -eq 1 ] ; then
    exit 1
fi

exit 0
