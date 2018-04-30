//  Launch configuration for the consul cluster auto-scaling group.
resource "aws_instance" "master" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  # Master nodes require at least 16GB of memory.
  instance_type               = "m4.xlarge"
  subnet_id                   = "${aws_subnet.private-subnet.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data                   = "${file("${path.module}/files/setup-master.sh")}"
  key_name                    = "${var.key_name}"

  security_groups = [
    "${aws_security_group.openshift-openshift-ingress.id}",
    "${aws_security_group.openshift-openshift-egress.id}"
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  tags {
    Name        = "${var.project}-${var.environment}-master"
    Environment = "${var.environment}"
    Project     = "${var.project}"

    // this tag is required for dynamic EBS PVCs
    // see https://github.com/kubernetes/kubernetes/issues/39178
    KubernetesCluster = "openshift-${var.region}"
  }
}

resource "aws_instance" "master" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  # Master nodes require at least 16GB of memory.
  instance_type               = "m4.xlarge"
  subnet_id                   = "${aws_subnet.private-subnet.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data                   = "${file("${path.module}/files/setup-master.sh")}"
  key_name                    = "${var.key_name}"

  security_groups = [
    "${aws_security_group.openshift-openshift-ingress.id}",
    "${aws_security_group.openshift-openshift-egress.id}"
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  tags {
    Name        = "${var.project}-${var.environment}-master"
    Environment = "${var.environment}"
    Project     = "${var.project}"


    KubernetesCluster = "openshift-${var.region}"
  }
}

resource "aws_instance" "node1" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${aws_subnet.private-subnet.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data                   = "${file("${path.module}/files/setup-node.sh")}"
  key_name                    = "${var.key_name}"

  security_groups = [
    "${aws_security_group.openshift-openshift-ingress.id}",
    "${aws_security_group.openshift-openshift-egress.id}"
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  tags {
    Name        = "${var.project}-${var.environment}-node1"
    Environment = "${var.environment}"
    Project     = "${var.project}"

    // this tag is required for dynamic EBS PVCs
    // see https://github.com/kubernetes/kubernetes/issues/39178
    KubernetesCluster = "openshift-${var.region}"
  }
}
