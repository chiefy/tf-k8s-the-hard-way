resource "aws_subnet" "main" {
  vpc_id = "${aws_vpc.kubernetes.id}"
  cidr_block = "10.240.0.0/24"
  tags {
    Name = "kubernetes"
  }
}
