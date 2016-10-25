A series of `terraform` templates and `Makefile` to aid with the great [Kubernetes the Hard Way tutorial](https://github.com/kelseyhightower/kubernetes-the-hard-way) by [Kelsey Hightower](https://github.com/kelseyhightower).

Currently this repo only supports Amazon Web Services, but will hopefully include GCE in the near future.

## Requirements
  * GNU Make (installed on most *nix OSes)
  * Valid AWS account w/ IAM keys
  * [CloudFlare's PKI Tookit](https://github.com/cloudflare/cfssl) 
  * [OpenSSL](https://www.openssl.org)
  * [Hashicorp Terraform](https://terraform.io)

## Instructions
  * clone the repo locally
  * copy `terraform.tfvars.example` to `terraform.tfvars` and include your own ssh-key
  * run `make` targets

## Make Targets

`make install` will try to install all dependencies using `brew`. If you don't have Homebrew installed, it will notify and error.


### Part I: AWS Infrastructure
The following targets will boostrap the steps in [part 1 of the tutorial](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-infrastructure-aws.md).

`make plan` will run terraform's `plan` command using `terraform.tfvars` in the root directory and show you expected infrastructure it will create.

`make apply` will run terraform's `apply` command, creating resources in AWS.


### Part II: Certificates

`make all-certs` will create all the certs and then `scp` them to the Kubernetes hosts created in Part I.

### Cleaning Up

`make clean` destroys AWS resources created in Part I and then also cleans up local certs created in Part II.

