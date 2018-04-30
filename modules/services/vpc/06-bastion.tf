resource "aws_instance" "bastion" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.micro"
  iam_instance_profile        = "${aws_iam_instance_profile.bastion-instance-profile.id}"
  subnet_id                   = "${aws_subnet.public-subnet.id}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/files/setup-bastion.sh")}"

  tags {
    Name        = "${var.project}-${var.environment}-bastion"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}
