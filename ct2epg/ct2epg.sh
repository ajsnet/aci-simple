#!/bin/sh  
#  ct2epg.sh - add contract to both provided and consumed for a given epg list
# EDIT THESE AS NEEDED
APIC_BASE=https://127.0.0.1/
MY_TENANT=TenantName
MY_AP=AppProfName
MY_CONTRACT=ContractName

# VARIOUS CONSTANTS - should not have to change
EPG_LIST_FILE=epglist.txt
LOGIN_URL=api/aaaLogin.json
APIC_API_TARGET_URL=api/mo/uni.json
AUTH_FILE=auth.json
CURL_POST=/tmp/curl_post.json
APIC_COOKIE=/tmp/apic_cookie.txt
echo --- APIC LOGIN
curl -X POST -k -c $APIC_COOKIE $APIC_BASE$LOGIN_URL --data @$AUTH_FILE
echo
# do the thing
for MY_EPG in $(cat epglist.txt); do
	echo --- ADDING $MY_CONTRACT to $MY_EPG
	cat epg_template.json|sed s/MY_TENANT/$MY_TENANT/g|sed s/MY_AP/$MY_AP/g|sed s/MY_EPG/$MY_EPG/g|sed s/MY_CONTRACT/$MY_CONTRACT/g > $CURL_POST
	curl -s -k -X POST --data @$CURL_POST -b $APIC_COOKIE $APIC_BASE$APIC_API_TARGET_URL
	echo
	sleep 1
done
echo --- REMOVING TEMPORARY FILES
rm $CURL_POST
rm $APIC_COOKIE
echo --- SCRIPT COMPLETE - VERIFY MANUALLY - THIS SCRIPT DOES NO VALIDATION
#end
