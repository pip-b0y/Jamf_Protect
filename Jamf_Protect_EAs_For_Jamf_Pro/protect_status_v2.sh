#!/bin/bash
protect_binary_path='/usr/local/bin/protectctl'
protect_check=$(which protectctl)
if [[ "${protect_check}" == "${protect_binary_path}" ]]; then
echo "Protect Installed check status"
status=$(sudo /usr/local/bin/protectctl info | grep 'Status' | awk '{print $2}')
echo "<result>${status}</result>"
else
echo "<result>Protect NotInstalled</result>"
fi
