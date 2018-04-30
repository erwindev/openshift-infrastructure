/* Default security group */
resource "aws_security_group" "openshift-vpc" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.openshift.id}"

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags {
    Name        = "${var.project}-${var.environment}-internal-vpc"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

resource "aws_security_group" "bastion" {
  vpc_id      = "${aws_vpc.openshift.id}"
  name        = "${var.environment}-bastion-host"
  description = "Allow SSH to bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.project}-${var.environment}-bastion-sg"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

resource "aws_security_group" "openshift-ingress" {
  name        = "${var.project}-${var.environment}-ingress"
  description = "Allow ssh, http, swarm traffic from Anywhere"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.project}-${var.environment}-openshift-ingress"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

resource "aws_security_group" "openshift-egress" {
  name        = "${var.project}-${var.environment}-egress"
  description = "Allow egress to anywhere"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.project}-${var.environment}-openshift-egress"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}
