resource "aws_key_pair" "main" {
  key_name = "kubernetes" 
  public_key = "${var.public_key}"
}
