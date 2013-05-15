#!/bin/bash

# (C) 2012 ACEnet
#
#  Test local disks - notify if cannot write a file to /tmp, /var/tmp or /scratch/tmp
# 	depending on how the node is provisioned, these may all test the same partition
#


TEST_ROOT_DIR="/tmp"
TEST_SCRATCH_DIR="/scratch/tmp"
TEST_VAR_DIR="/var/tmp"
TEST_FILE="foobar-user"
TEST_SOURCE_FILE="/etc/hosts"
FAILED=0

HOST="/usr/bin/host"
HOSTNAME="/bin/hostname"
CP="/bin/cp"
RM="/bin/rm"

${CP} ${TEST_SOURCE_FILE} ${TEST_ROOT_DIR}/${TEST_FILE} >/dev/null 2>&1
if [ $?  -eq 0 ] ; then
    ${RM} -f ${TEST_ROOT_DIR}/${TEST_FILE}  2>&1
else
    echo Node `${HOSTNAME}` cannot write to /, read-only file system?
    FAILED=1
fi

# ...at MUN (and DAL?), blades do not have a /scratch dir
if [ -d ${TEST_SCRATCH_DIR} ] ; then
   ${CP} ${TEST_SOURCE_FILE} ${TEST_SCRATCH_DIR}/${TEST_FILE} >/dev/null 2>&1
   if [ $?  -eq 0 ] ; then
       ${RM} -f ${TEST_SCRATCH_DIR}/${TEST_FILE}  2>&1
   else
       echo Node `${HOSTNAME}` cannot write to /scratch, read-only file system?
       FAILED=1
   fi
fi

${CP} ${TEST_SOURCE_FILE} ${TEST_VAR_DIR}/${TEST_FILE} >/dev/null 2>&1
if [ $?  -eq 0 ] ; then
    ${RM} -f ${TEST_VAR_DIR}/${TEST_FILE}  2>&1
else
    echo Node `${HOSTNAME}` cannot write to /var, read-only file system?
    FAILED=1
fi

if [ $FAILED -eq 1 ] ; then
    echo " "
    exit 1
fi

exit 0
