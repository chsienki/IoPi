#!/bin/bash

if [ -z "$1" ]; then 
    echo "Usage: installer.sh install_dir"
    exit 0;
fi


install_location=$1
script_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

exist_cmdline="$install_location/cmdline.txt"
new_cmdline="$script_root/cmdline.txt.template"

bootstrapper_folder="$script_root/../bootstrapper"
service_folder="$script_root/../service"

echo "Installing into $install_location"

if [ ! -f "$exist_cmdline" ]; then
    echo "Couldn't find cmdline.txt in $install_location. Are you sure this is a valid install location?"
    exit -1
fi

if [ ! -f "$exist_cmdline.orig" ]; then 
    echo "Backing up cmdline.txt -> cmdline.txt.orig"
    mv "$exist_cmdline" "$exist_cmdline.orig"
else 
    echo "cmdline.txt.orig already exists. No backup will be created"
fi

cp "$new_cmdline" "$exist_cmdline"
cp "$bootstrapper_folder" "$install_location/." -r
cp "$service_folder" "$install_location/." -r
cp "$script_root/../iopi-config.txt" "$install_location/." #TODO only copy if these exist
cp "$script_root/../iopi-startup.sh" "$install_location/."