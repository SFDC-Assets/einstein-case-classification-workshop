sfdx shane:org:create -f config/project-scratch-def.json -d 30 -s --wait 60 --userprefix case -o classification.einstein
sfdx force:source:push
sfdx shane:user:password:set -p salesforce1 -g User -l User

#assign  AUDIT FIELD AND Einstein Case Classification User permsets
sfdx force:user:permset:assign --perm-set-name Audit_Fields
sfdx force:user:permset:assign --perm-set-name EinsteinAgent

#assign AUDIT FIELD AND Einstein Case Classification User permsets TO INTEGRATION USER
sfdx force:user:permset:assign --perm-set-name Audit_Fields -u integ

#install Einstein Case Classification Value Analytics
sfdx force:package:install -p 04tB0000000UQjfIAG --noprompt -w 5

#bulk load Closed Cases
sfdx shane:data:dates:update -r 09-24-2020
sfdx force:data:bulk:upsert -s Case -f data-modified/extracttaskclean1.csv -i ID

#load task
sfdx force:data:bulk:upsert -s Task -f data-modified/ClosedCases.csv -i External_Id__c

sfdx force:org:open