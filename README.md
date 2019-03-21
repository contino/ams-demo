# OCIS

## Requirements

- An AWS Acconut to store files & do test Deploys
- An AMS Account to do deploys
- Docker

You can use a federated login via `docker run --rm -it -v ~/.aws:/root/.aws dtjohnson/aws-azure-login` to configure your local aws config file on your host machine.

## Development Container

 
**Start your container:**

- Create your own container for local development: `docker build . -t origin-aws-ansible`.
- Run your container: `docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/opt/app origin-aws-ansible bash`

**Once you're in your container:**

There are 2 playbooks...

- Create Stack: `ansible-playbook ocis-playbook.yml --extra-vars env=nonprod`
- RDP Access: `ansible-playbook ocis-access-playbook.yml --extra-vars "env=nonprod username=lastf"`

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



