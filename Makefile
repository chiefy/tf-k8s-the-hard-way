
TERRAFORM = $(shell which terraform 2> /dev/null)
CFSSL = $(shell which cfssl 2> /dev/null)
CFSSLJSON = $(shell which cfssljson 2> /dev/null)
OPENSSL = $(shell which openssl 2> /dev/null)
HOMEBREW = $(shell which brew 2> /dev/null)
JQ = $(shell which jq 2> /dev/null)

.PHONY: check_deps clean install plan apply all-certs kube-dns kube-hosts

check_deps:
ifndef TERRAFORM
	@echo;echo "Sorry, you need to install Hashicorp Terraform - https://terraform.io";echo; exit 1
endif
ifndef CFSSL
	@echo;echo "Sorry, you need to install CloudFlare's PKI toolkit - https://github.com/cloudflare/cfssl";echo; exit 1
endif
ifndef CFSSLJSON
	@echo;echo "Sorry, you need to install CloudFlare's PKI toolkit - https://github.com/cloudflare/cfssl";echo; exit 1
endif
ifndef OPENSSL
	@echo;echo "Sorry, you need to install OpenSSL - try `brew install openssl`";echo; exit 1
endif
ifndef JQ
	@echo;echo "Sorry, you need to install JQ - try `brew install jq`";echo; exit 1
endif

define tform
terraform $@ ./tf
endef

apply: check_deps
	$(tform)

destroy: check_deps
	$(tform)

plan: check_deps
	$(tform)

kube-dns: check_deps
	@terraform output -json kube_dns | jq .value

kube-hosts: check_deps
	@terraform output kube_hosts

install:
ifndef HOMEBREW
	@echo;echo "Sorry, you need to install Homebrew - http://brew.sh";echo; exit 1
endif
	@echo "Installing dependencies with homebrew."
	@$(HOMEBREW) install terraform cfssl openssl jq

certs: check_deps conf/kubernetes-csr.json
	@mkdir -p $@
	@cd $@ \
	&& $(CFSSL) gencert \
		-initca ../conf/ca-csr.json | $(CFSSLJSON) -bare ca
	@$(OPENSSL) x509 -in $@/ca.pem -text -noout 
	@cd $@ \
	&& $(CFSSL) gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=../conf/ca-config.json \
		-profile=kubernetes \
		../conf/kubernetes-csr.json | $(CFSSLJSON) -bare kubernetes
	@$(OPENSSL) x509 -in $@/kubernetes.pem -text -noout

conf/kubernetes-csr.json: check_deps
	@jq ".hosts = .hosts + $(shell make kube-dns)" < ./conf/kubernetes-csr.tmpl.json > $@

all-certs: certs
	@./scripts/copy-certs.sh

clean: destroy
	@rm -rf certs conf/kubernetes-csr.json
