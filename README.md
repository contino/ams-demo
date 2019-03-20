# OCIS

## Requirements

- An AWS Acconut to store files & do test Deploys
- An AMS Account to do deploys
- Docker

You can use a federated login via `docker run --rm -it -v ~/.aws:/root/.aws dtjohnson/aws-azure-login` to configure your local aws config file on your host machine.

## Development Container

**Start your container:**

`docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/opt/app contino/aws-cli bash`

When you're in the container, install Ansible (we will include that in the future to save time):

`apk add ansible` 

Then run Ansible:

`ansible-playbook ocis-playbook.yml --extra-vars env=nonprod`

## Using Ansible

```
# skip the cf run
ansible-playbook ocis-playbook.yml --extra-vars env=nonprod --skip-tags cf

# skip validate
ansible-playbook ocis-playbook.yml --extra-vars env=nonprod --skip-tags validate

# skip ams tasks
ansible-playbook ocis-playbook.yml --extra-vars env=nonprod --skip-tags validate

# skip validate and ams (cf create only)
ansible-playbook ocis-playbook.yml --extra-vars env=nonprod --skip-tags 'ams, validate'
```



