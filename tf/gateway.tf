resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.kubernetes.id}"
  tags {
    Name = "kubernetes"
  }
}
