resource "aws_vpc" "kubernetes" {
  cidr_block = "10.240.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags {
    Name = "kubernetes"
  }
}

resource "aws_vpc_dhcp_options" "kubernetes" {
  domain_name = "us-east-1.compute.internal"
  domain_name_servers = ["127.0.0.1", "AmazonProvidedDNS"]
  tags {
    Name = "kubernetes"
  }
}

resource "aws_vpc_dhcp_options_association" "kubernetes" {
  vpc_id = "${aws_vpc.kubernetes.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.kubernetes.id}"
}
