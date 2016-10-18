resource "aws_elb" "main" {
  name = "kubernetes"

  listener {
    instance_port = 6443
    instance_protocol = "tcp"
    lb_port = 6443
    lb_protocol = "tcp"
  }

  security_groups = ["${aws_security_group.main.id}"]
  subnets = ["${aws_subnet.main.id}"]

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "kubernetes-elb"
  }

}
