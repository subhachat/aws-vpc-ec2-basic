resource "aws_vpc" "dev_web" {
    cidr_block              = "10.0.0.0/24"
    enable_dns_support      = true
    enable_dns_hostnames    = true
    instance_tenancy        = "default"

    tags = {
      "name"        = "dev_web"
      "purpose"     = "workspace"
      "provisioner" = "terraform"
    }
}

resource "aws_subnet" "public_dev_web_a" {
    vpc_id                  = "${aws_vpc.dev_web.id}"
    cidr_block              = "10.0.0.0/28"
    availability_zone       = "${var.AWS_REGION}a"
    map_public_ip_on_launch = true // this is declaring public subnet 

    tags = {
      "name"        = "public_dev_web_a"
      "purpose"     = "workspace"
      "provisioner" = "terraform"
    }
}
