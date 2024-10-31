sf demoutil org create scratch -f config/project-scratch-def.json -d 5 -s -p case -e classification.workshop
sf project deploy start
sf demoutil user password set -p salesforce1 -g User -l User

#assign  AUDIT FIELD AND Einstein Case Classification User permsets
sf org assign permset -n Audit_Fields
sf org assign permset -n EinsteinAgent

#install Einstein Case Classification Value Analytics
sf package install -p 04tHr000000k9NX --noprompt -w 5

#bulk load Closed Cases
sfdx shane:data:dates:update -r 09-24-2020
sf data bulk upsert -s Task -f data-modified/extracttaskclean1.csv -i ID

#load task
sf data bulk upsert -s Case -f data-modified/ClosedCases.csv -i External_Id__c

sf org open
