#!/bin/bash
protect_binary_path='/usr/local/bin/protectctl'
protect_check=$(which protectctl)
if [[ "${protect_check}" == "${protect_binary_path}" ]]; then
echo "<result>Protect Installed</result>"
else
echo "<result>Protect NotInstalled</result>"
fi
