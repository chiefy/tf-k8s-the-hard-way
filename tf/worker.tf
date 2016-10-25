resource "aws_instance" "worker" {
    count = 3
    ami = "${var.ami_id[var.aws_region]}"
    instance_type = "${var.ec2_instance_types["worker"]}"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.main.id}"]
    subnet_id = "${aws_subnet.main.id}"
    source_dest_check = false
    private_ip = "10.240.0.2${count.index}"
    iam_instance_profile = "${aws_iam_instance_profile.kubernetes.name}"
    key_name = "${aws_key_pair.main.key_name}"
    tags {
        Name = "worker${count.index}"
    }
}
