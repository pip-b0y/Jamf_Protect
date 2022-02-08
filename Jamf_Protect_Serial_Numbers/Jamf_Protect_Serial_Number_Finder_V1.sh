#!/bin/bash
###ONLY READS OBJECTS. SCRIPT IS AS IS.
###Please hard code your client_id + api password in Line 14 of the script.
#This script will find devices that have protect installed and will check Jamf Protect to see if the device is present. If Protect is installed and not found in the Protect tenant it is likely either enrolled into a different tenant or appears as null
protect_tenant='' #Just need the tenant name so just the first part of your protect url
client_id='' #see https://docs.jamf.com/jamf-protect/documentation/Jamf_Protect_API.html
api_password='' #see https://docs.jamf.com/jamf-protect/documentation/Jamf_Protect_API.html
jssurl='' #Full Jamf Pro URL (with HTTPS)
jssuser='' #admin user name
jsspass='' #admin password
groupname_raw='' #Smart group that has devices with protect installed
####ACCESS TOKEN####
#Note Need the access token
access_token=$(curl --request POST --header 'content-type: application/json' --url "https://${protect_tenant}.protect.jamfcloud.com/token" --data '{"client_id": "CLIENT_ID_HERE", "password": "API_PASSWORD_HERE"}' | python -c 'import json,sys;obj=json.load(sys.stdin);print obj ["access_token"]' )
#############################
###Protect Action###
###Grab a list of serial numbers###
curl --header "Content-Type: application/json" --header "Authorization: ${access_token}" -X POST "https://${protect_tenant}.protect.jamfcloud.com/graphql" --data '{"query": "query {listComputers {items {serial}}}"}' | python -c 'import json,sys;obj=json.load(sys.stdin);print obj ["data"]["listComputers"]["items"]' > /tmp/raw_data.json
####Convert the list to just serial numbers.
raw_protect_data=$(cat /tmp/raw_data.json)
IFS=', ' read -r -a array <<< "$raw_protect_data"
for (( raw_protect_data=1; raw_protect_data<=(${#array[@]}-1); raw_protect_data+=2 )); do
echo ${array[$raw_protect_data]} | tr -d "u'}]" >> /tmp/protect_serials.log
done
#######
###Getting information from Jamf Pro
#Assuming auth tokens are not in use and jamf pro is 10.35 and below
#Use token
token=$(printf "${jssuser}:${jsspass}" | iconv -t ISO-8859-1 | base64 -i -)
##Remove Spaces from the group name
groupname=$(printf "%s\n" "${groupname_raw}" | sed 's/ /%20/g' )
#serial Number
#curl -sk --header "authorization: Basic ${token}" ${jssurl}/JSSResource/computergroups/name/${groupname} | xmllint --format - | awk -F'[<|>]' '/<serial_number>/{print $3}' > /tmp/jamfPro_serial.log
jamfproserialraw=$(curl -sk --header "authorization: Basic ${token}" ${jssurl}/JSSResource/computergroups/name/${groupname} | xmllint --format - | awk -F'[<|>]' '/<serial_number>/{print $3}')
for mac_serial in ${jamfproserialraw};do
#check the protect list for serial number from pro
results=$(cat /tmp/protect_serials.log | grep "${mac_serial}")
if [[ "${results}" == "${mac_serial}" ]]; then
echo "${mac_serial} found in protect" >> /tmp/final_report.log
else
echo "${mac_serial} Not Found in Protect" >> /tmp/final_report.log
fi
done
echo "the final report can be found in /tmp/final_report.log"