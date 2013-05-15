# Sysverify Tests #

This directory contains all test scripts/programs that may be run by the
sysverify application. All scripts MUST respond in the following fashion

### OK ###
* exit code "0" with nothing sent to STDOUT

### Failure ###
* exit code anything but zero

STDERR is redirected to STDOUT and all output to STDOUT is used as the
result of the test. If the exit code is not zero but there is nothing in
STDOUT/STDERR then it is considered an "UNKNOWN ERROR"
