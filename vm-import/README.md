# VMImport



```
# create bucket in origin-anp (cloud-migration-green-team) and give permission to drew 584aa5b95189b214cd2d96d2b503d78d62d6dd34fd8df8a4e412fe504e451551

# copy file from AMS to origin-anp
aws s3 cp s3://test-contino-wigs/9600.16415.amd64fre.winblue_refresh.130928-2229_server_serverdatacentereval_en-us.vhd s3://cloud-migration-green-team/win.vhd


aws iam create-role --role-name vmimport --assume-role-policy-document "file://vm-import/trust-policy.json" --profile origin-anp
aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document "file://cm-import/role-policy.json"


aws ec2 import-image --description "Windows Test Contino" --disk-containers file://vm-import/win.json --profile origin-anp

aws ec2 describe-import-image-tasks --import-task-ids import-ami-xxx

```
