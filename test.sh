#!/bin/bash
set -uex

# This branch and test is for the 0.8.X versions of lnav
[[ "$(lnav -V)" == lnav\ 0.8* ]]

# If we have the latest lnav version, check that there are no warnings
test "$(lnav -V)" == "lnav 0.8.2" && \
  (! (lnav-0.8.2/lnav |& grep "^warning:"))

lnav -C

# Test that the different fields are extracted correctly
lnav -qn -c ';select xapi_timestamp,level,xapi_hostname,threadid,origin,task,module from xensource_log_module_format' -c ':write-csv-to /tmp/out.csv' ./test/test_captures/xensource.log
diff /tmp/out.csv test/test_captures/expected_matches.csv
