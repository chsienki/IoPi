#!/bin/bash

# bring in the lib
. "/opt/iopi/bin/lib.sh"

download_file="$iopi_var/iopi-downloaded-script.sh"
logfile="$iopi_var/output.log"
local_file="/boot/iopi-startup.sh"
startupfile=

if [ -f "$local_file" ]; then
	echo "Using local startup file"
	startupfile=$local_file
else
	bootstrap_url=$(read-config bootstrap_url)
	download-file $bootstrap_url $download_file
	startupfile=$download_file
fi

chmod +x "$startupfile"
. $startupfile