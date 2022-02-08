Jamf Protect Serial Number Finder.

This script uses both the Jamf Protect API and the Jamf Pro API. 

For the best results, have a smart group in Jamf Pro to identify all of the devices with Protect Installed. The script will compare the list from Jamf Protect with the List from Jamf Pro and check to see if the serial number from Pro is in Protect.
It will flag devices that are not in Protect but have Protect installed. A better smart group identifing devices that are Protected + enrolled would give the best results. How ever this script assumes that the deivces in the smart group are considered to be fully operational


