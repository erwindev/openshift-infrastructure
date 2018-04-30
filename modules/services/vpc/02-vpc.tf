/* Define the VPC */
resource "aws_vpc" "openshift" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name        = "${var.project}-${var.environment}-vpc"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "openshift" {
  vpc_id = "${aws_vpc.openshift.id}"

  tags {
    Name        = "${var.project}-${var.environment}-igw"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

/* Public subnet */
resource "aws_subnet" "public-subnet" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.environment}-public-subnet"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

/* Private subnet */
resource "aws_subnet" "private-subnet" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.private_subnet_cidr}"
  map_public_ip_on_launch = false
  availability_zone       = "${var.availability_zone}"

  tags {
    Name        = "${var.environment}-private-subnet"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.openshift.id}"

  tags {
    Name        = "${var.project}-${var.environment}-public-route-table"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.openshift.id}"

  tags {
    Name        = "${var.project}-${var.environment}-private-route-table"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}
