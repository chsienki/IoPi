#!/bin/bash

function read-config
{
	local key=$1
	cat /boot/iopi-config.txt | awk -F= -vOFS== '$1=="'$key'" { $1=""; print substr($0,2) }'
	
	#-f=  					split on '='
	#-vOFS== 				use '=' as output separator
	#$1=='$key' 			the line that matches first field equal to $key
	#{ $1 = ""; 			set the key to empty
	#print substr($0, 2)	print out the whole match ($0), starting at character 2 (skips the leading '=')
}

function get-bootstrap
{
	local bootstrap_url=$(read-config bootstrap_url)
	local output=$1
	curl --header "Accept: application/vnd.github.v3.raw" \
		 --location \
		 -o $output \
		 $bootstrap_url
}

function run
{
	#TODO: put these in var, not the root dir!
	local bootstrap_file="iopi-downloaded-script.sh"
	local logfile="downloaded-output.log"
	get-bootstrap $bootstrap_file
	chmod +x $bootstrap_file
	
	. $bootstrap_file >| $logfile
}
run