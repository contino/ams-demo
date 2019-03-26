# OCIS

## I'm in the fast lane!
 
**Start your container:**

- Create your own container for local development: `docker build . -t origin-aws-ansible`
- Run your container: `docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/opt/app origin-aws-ansible bash`

**Once you're in your container:**

- Stack Create: `ansible-playbook ocis-stack-create.yml --extra-vars env=nonprod`
- Stack Update: `ansible-playbook ocis-stack-update.yml --extra-vars env=nonprod`
- Stack Access: `ansible-playbook ocis-stack-access.yml --extra-vars "env=nonprod username=lastf"`


## Requirements

- An AWS Acconut to store files (in S3) & do test Deploys (CF Stacks)
- An AMS Account to do deploys (CF Stacks via RFCs)
- Docker (to run the scripts in this repo)



# Tips

Make sure your `~/.aws` configuration includes the appropriate profile name & region (for AMS and for AWS).

Windows users should replace `~/.aws` with the full path to thier aws config folder, e.g `C:\Users\userx\.aws`.

Windows users should also replace `$(pwd)` with the current directory for this repo e.g `C:\Users\userx\repos\this-repo`

If you have problems mounting volumes in docker make sure you've shared your volumes in Docker Preference (ie `C:` or `/Users`).

You can perform a federated login to AMS with `docker run --rm -it -v ~/.aws:/root/.aws dtjohnson/aws-azure-login` to configure your local aws config file on your host machine. Your AWS config may end up looking a little like this when you're done:

```
[default]
region=ap-southeast-2
output=json
azure_tenant_id=97160e56-eb00-44fe-b31d-0d6d351c636d
azure_app_id_uri=https://origin-ams-nonprod.signin.aws.amazon.com/console
azure_default_username=first.last@origin.com.au
azure_default_role_arn=xx
azure_default_duration_hours=1

[profile originusers]
region=ap-southeast-2
aws_access_key_id=xx
aws_secret_access_key=xx
mfa_serial=arn:aws:iam::83xxx64:mfa/first.last

[profile origin-anp]
role_arn=arn:aws:iam::18xx79:role/UsersXXX
source_profile=originusers
region=ap-southeast-2
mfa_serial=arn:aws:iam::83xxx64:mfa/first.last
```


# Example Ansible Commands

```
# skip the cf run
ansible-playbook ocis-stack-create.yml --extra-vars env=nonprod --skip-tags cf

# skip validate
ansible-playbook ocis-stack-create.yml --extra-vars env=nonprod --skip-tags validate

# skip ams tasks
ansible-playbook ocis-stack-create.yml --extra-vars env=nonprod --skip-tags ams

# skip validate and ams (cf create only)
ansible-playbook ocis-stack-create.yml --extra-vars env=nonprod --skip-tags 'ams, validate'
```



