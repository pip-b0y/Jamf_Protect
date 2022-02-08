#!/bin/bash
protect_binary_path='/usr/local/bin/protectctl'
protect_check=$(which protectctl)
if [[ "${protect_check}" == "${protect_binary_path}" ]]; then
echo "Protect Installed check status"
plan_id=$(sudo /usr/local/bin/protectctl info | grep 'Plan ID:' | awk '{print $3}')
echo "<result>${plan_id}</result>"
else
echo "<result>No Plan</result>"
fi