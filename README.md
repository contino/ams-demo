# ams-demo

## CFN Demo

Things to change:

3-tier.json

- ams-shared/stage-otdb-new is hardcoded


params.json

- bucket + token
- name tag
- instance profile
- subnets + vpc



**Create the RFC**


```
aws amscm create-rfc --change-type-id ct-36cn2avfrrj9v --change-type-version "1.0" --title "Contino Remo please ignore test cfn ingest" --execution-parameters "file://amsparameters.json" --region us-east-1
```

**Submit the RFC**

```
aws amscm submit-rfc --rfc-id "6cb4bd5a-a816-bd1a-c49c-14f830ad9336" --region us-east-1
```


**presign**

```
aws s3 presign --expires-in 7200 remos3/3-tier-cfn-ingest.json
```

notes:

The amsparameters.json file was stored locally when I ran this command i.e. in C:/temp/amsparameters.json
In the amsparameters.json file, the "CloudFormationTemplateS3Endpoint" points to my S3 bucket with a presigned link (e.g. using aws s3 presign --expires-in 7200 remos3/3-tier-cfn-ingest.json) - This will have expired by the time you run this demo.


# Containers

```
docker pull ansible/ansible-runner
docker pull contino/aws-cli
```


**Federated login**

```
docker run --rm -it -v ~/.aws:/root/.aws dtjohnson/aws-azure-login
```

**AWS CLI & AMS**

```
docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/opt/app contino/aws-cli bash
cd ./lib/ams && ./AWSManagedServices_InstallCLI.sh && cd ../../

```

**AMS CF RFC**

```
BUCKET_NAME=test-contino-wigs
TEMPLATE_FILE=test.json

aws cloudformation validate-template --template-body file://./${TEMPLATE_FILE}
aws s3 cp ${TEMPLATE_FILE} s3://${BUCKET_NAME}/${TEMPLATE_FILE}
export S3_PRESIGNED_URL=$(aws s3 presign --expires-in 86400 s3://${BUCKET_NAME}/${TEMPLATE_FILE})

aws amscm create-rfc \
--change-type-id ct-36cn2avfrrj9v --change-type-version "1.0" \
--title "Contino test cfn ingest v2" \
--execution-parameters "file://test-params.json" --region us-east-1

RFC_ID=dab4bfb8-0c69-ecf7-765c-f54b3f702137
aws amscm submit-rfc --rfc-id ${RFC_ID} --region us-east-1

aws amscm get-rfc --rfc-id ${RFC_ID} --query "Rfc.{Status:Status.Name,Exec:ExecutionOutput}" --region us-east-1

```




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
