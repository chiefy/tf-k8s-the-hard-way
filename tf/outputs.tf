output "kube_dns" {
  value = ["${jsonencode(aws_elb.main.dns_name)}"]
}

output "kube_hosts" {
  value = "${join(" ", concat(aws_instance.worker.*.public_ip, aws_instance.controller.*.public_ip))}"
}
