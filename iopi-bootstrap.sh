#!/bin/bash

function read-config
{
	local key=$1
	cat /boot/config.txt | awk -F= -vOFS== '$1=="'$key'" { $1=""; print substr($0,2) }'
	
	#-f=  					split on '='
	#-vOFS== 				use '=' as output separator
	#$1=='$key' 			the line that matches first field equal to $key
	#{ $1 = ""; 			set the key to empty
	#print substr($0, 2)	print out the whole match ($0), starting at character 2 (skips the leading '=')
}

function get-bootstrap
{
	local bootstrap_url=$(read-config bootstrap_url)
	local token=$(read-config github_pat)
	local output=$1
	curl --header "Authorization: token $token" \
		 --header "Accept: application/vnd.github.v3.raw" \
		 --location \
		 $1
		 $bootstrap_url
}

function run
{
	local bootstrap_file="iopi-bootstrap-download.sh"
	get-bootstrap $bootstrap_file
	chmod +x $bootstrap_file
	. $bootstrap_file
}
run