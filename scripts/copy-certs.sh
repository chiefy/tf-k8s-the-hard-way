#!/bin/sh

KUBERNETES_HOSTS=( $(make -I ../ kube-hosts) )

for ip_address in ${KUBERNETES_HOSTS[@]}; do
  echo
  echo "Copying certs to ${ip_address}..."
  scp \
    certs/ca.pem \
    certs/kubernetes-key.pem \
    certs/kubernetes.pem \
    ubuntu@${ip_address}:~/
done
