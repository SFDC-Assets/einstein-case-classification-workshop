sfdx shane:org:create -f config/project-scratch-def.json -d 30 -s --wait 60 --userprefix case -o classification.einstein
sfdx force:source:push
sfdx shane:user:password:set -p salesforce1 -g User -l User

#assign  AUDIT FIELD AND Einstein Case Classification User permsets
sfdx force:user:permset:assign --perm-set-name Audit_Fields
sfdx force:user:permset:assign --perm-set-name EinsteinAgent

#install Einstein Case Classification Value Analytics
sfdx force:package:install -p 04tB0000000UQjfIAG --noprompt -w 5

#bulk load Closed Cases
sfdx shane:data:dates:update -r 09-24-2020
sfdx force:data:bulk:upsert -s Case -f data-modified/extracttaskclean1.csv -i External_Id__c

#load task
sfdx force:data:bulk:upsert -s Task -f data-modified/ClosedCases.csv -i ID

sfdx force:org:open