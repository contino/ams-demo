# OCIS

## Requirements

You need access to an AWS Account. Currently the hardcoded expectation is that you an AWS profile `origin-anp` on your local computer.

You also need access to AMS. You can use a federated login via `docker run --rm -it -v ~/.aws:/root/.aws dtjohnson/aws-azure-login` to configure your local aws config file.

## Development Container

**Start your container:**

`docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/opt/app contino/aws-cli bash`

When you're in the container, install Ansible (we will include that in the future to save time):

`apk add ansible` 

Then run Ansible:

`ansible-playbook ocis-playbook.yml`

## Using Ansible

```
# skip the cf run
ansible-playbook ocis-playbook.yml --skip-tags cf

# skip validate
ansible-playbook ocis-playbook.yml --skip-tags validate

# skip ams tasks
ansible-playbook ocis-playbook.yml --skip-tags validate

# skip validate and ams (cf create only)
ocis-playbook.yml --skip-tags 'ams, validate'
```



