#!/bin/bash

# (C) 2012 ACEnet
#
#  Test NFS - notify if cannot mount and write a file to /home
#  This test expects the following TEST_? directories to exist
#


TEST_HOME_DIR="/home/user"
TEST_SOURCE_FILE="/etc/hosts"

FAILED=0

TOUCH="/usr/bin/touch"
CP="/bin/cp"
RM="/bin/rm"
HOSTNAME="/bin/hostname"
LS="/bin/ls"

FILENAME="junk-foobar-"
TEST_FILE=${FILENAME}`${HOSTNAME}`

#  Test /home automount
#
`${LS} ${TEST_HOME_DIR} >/dev/null 2>&1`
if [ $? -ne 0 ] ; then
    echo Node `${HOSTNAME}` cannot reach home directory
    FAILED=1
else
${CP} ${TEST_SOURCE_FILE} ${TEST_HOME_DIR}/${TEST_FILE} >/dev/null 2>&1
    if [ $? -eq 0 ] ; then
        ${RM} -f ${TEST_HOME_DIR}/${TEST_FILE} 2>/dev/null
    else
        echo Node `${HOSTNAME}` cannot write to home directory, read-only file system?
        FAILED=1
    fi
fi

if [ $FAILED -eq 1 ] ; then
    exit 1
fi

exit 0
