# ct2epg README.md
The purpose of this script is to provide a simple means to add contracts to a list of EPGs via the APIC's RESTful API.
# Requirements
These requirements can be easily met by nearly any linux host
- bash shell
- sed
- curl
- script assumes /tmp is writable for temporary files during execution
# Notes
This script does not do any meaningful error checking.
The provided EPG template will add the given contract as both Provided and Consumed.  This behavior can be changed by editing the epg_template.json file.
# Key files
-ct2epg.sh - bash script to execute (e.g., "sh ct2epg.sh")
-epg_template.json - json template of EPG, can be customized for only Provider or Consumer
-auth.json - json file containing username/password to login to the APIC
-epglist.txt - text file, list of EPGs (one per line) to affect
# Misc (generated) files
- /tmp/curl_cookies.txt - this is dynamically generated/updated by curl and can be ignored
- /tmp/curl_post.json - this is dynamically generated/updated as ct2epg loops through the EPGs to affect
# Making it work
- Edit the auth.json file with user/pass for APIC
- (Optional) Edit EPG template to only affect provide or consume if required
- Edit the ct2epg.sh to reflect target Tenant/AppProf/Contract
- Replace epglist.txt with your EPG list
- Run 'sh ct2epg.sh'
- Login to APIC to verify
