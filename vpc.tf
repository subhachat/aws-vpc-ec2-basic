resource "aws_vpc" "dev_vpc_eu_west2_subhachat" {
    cidr_block              = "10.0.0.0/24"
    enable_dns_support      = true
    enable_dns_hostnames    = true
    instance_tenancy        = "default"
    tags = {
      "name"        = "dev_vpc_eu_west2_subhachat"
      "purpose"     = "dev_workspace"
      "provisioner" = "terraform"
    }
}

resource "aws_subnet" "dev_public_subnet01_eu_west2a_subhachat" {
    vpc_id                  = "${aws_vpc.dev_vpc_eu_west2_subhachat.id}"
    cidr_block              = "10.0.0.0/28"
    availability_zone       = "eu-west-2a"
    map_public_ip_on_launch = true // this is declaring public subnet 
    tags = {
      "name"        = "dev_public_subnet01_eu_west2a_subhachat"
      "purpose"     = "dev_workspace"
      "provisioner" = "terraform"
    }
}
