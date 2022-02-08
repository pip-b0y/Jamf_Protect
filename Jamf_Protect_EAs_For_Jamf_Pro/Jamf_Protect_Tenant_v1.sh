#!/bin/bash
protect_binary_path='/usr/local/bin/protectctl'
protect_check=$(which protectctl)
if [[ "${protect_check}" == "${protect_binary_path}" ]]; then
echo "Protect Installed check status"
tenant=$(sudo /usr/local/bin/protectctl info | grep 'Tenant' | awk '{print $2}')
echo "<result>${tenant}</result>"
else
echo "<result>No Tenant</result>"
fi