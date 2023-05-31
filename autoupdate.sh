#!/bin/bash
# autoupdate.sh - my solution to deal with these updates
# 'cause I'm fed up with the notifications. Like man, am
# I f*cking using Arch? Licensed under WTFPL.

# after every step we have to conduct this function.
# its purpose is really simple: if something breaks,
# it can automatically cancel the script and return 0.
function halt_on_fail {
	if [ $? != 0 ]; then # something failed its job
		exit $?
	fi
}

# update automtically, record results to /var/log/autoupdated.d/autoupdated.log and errors to /var/log/autoupdated/autoupdated.stderr.log

if [ ! -d "/var/log" ]; then # not likely to happen but who knows what can happen
	mkdir "/var/log"
	halt_on_fail
fi

if [ ! -d "/var/log/autoupdated.d" ]; then # likely to happen - if the directory for autoupdated does not exist, create one. 
	mkdir "/var/log/autoupdated.d"
	halt_on_fail
fi

touch "/var/log/autoupdated.d/autoupdated.log" && halt_on_fail
touch "/var/log/autoupdated.d/autoupdated.stderr.log" && halt_on_fail

# update everything on the distribution.
# say yes to any question asked.
exec yes | exec sudo dnf distro-sync  1>"/var/log/autupdated.d/autoupdated.log" 2>"/var/log/autoupdated.d/autoupdated.stderr.log" 
halt_on_fail


