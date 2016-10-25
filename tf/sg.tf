resource "aws_security_group" "main" {
  name = "kubernetes"
  description = "Kubernetes security group"
  vpc_id = "${aws_vpc.kubernetes.id}"
  
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
    cidr_blocks = ["10.240.0.0/16"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "kubernetes"
  }

}
