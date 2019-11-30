#!/bin/bash

iopi_root="/opt/iopi" #TODO: read this from the file location?
iopi_var="$iopi_root/var"
iopi_bin="$iopi_root/bin"

read-config()
{
	local key=$1
	cat /boot/iopi-config.txt | awk -F= -vOFS== '$1=="'$key'" { $1=""; print substr($0,2) }'
	
	#-f=  					split on '='
	#-vOFS== 				use '=' as output separator
	#$1=='$key' 			the line that matches first field equal to $key
	#{ $1 = ""; 			set the key to empty
	#print substr($0, 2)	print out the whole match ($0), starting at character 2 (skips the leading '=')
}

download-file()
{
    local url=$1
	local output=$2
	echo "Downloading $url -> $output"
	curl --location \
		 -o $output \
		 $url
}