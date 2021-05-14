resource "aws_internet_gateway" "dev_igw_eu_west2_subhachat" {
    vpc_id = "${aws_vpc.dev_vpc_eu_west2_subhachat.id}"
    tags = {
        "name"          = "dev_igw_eu_west2_subhachat"
        "purpose"       = "dev_workspace"
        "provisioner"   = "terraform"
    }
}

resource "aws_route_table" "dev_public_routetbl_eu_west2_subhachat" {
    vpc_id = "${aws_vpc.dev_vpc_eu_west2_subhachat.id}"
    
    route {
      cidr_block                    = "0.0.0.0/0"
      gateway_id                    = "${aws_internet_gateway.dev_igw_eu_west2_subhachat.id}"
    }

    tags = {
        "name"          = "dev_public_routetbl_eu_west2_subhachat"
        "purpose"       = "dev_workspace"
        "provisioner"   = "terraform"
    }
}

resource "aws_route_table_association" "dev_public_assoc_routetbl_subnet01_eu_west2_subhachat" {
    subnet_id       = "${aws_subnet.dev_public_subnet01_eu_west2a_subhachat.id}"
    route_table_id  = "${aws_route_table.dev_public_routetbl_eu_west2_subhachat.id}"
}

resource "aws_security_group" "dev_sg_ssh_http_allowed_eu_west2_subhachat" {
    vpc_id = "${aws_vpc.dev_vpc_eu_west2_subhachat.id}"
    egress {
      cidr_blocks           = [ "0.0.0.0/0" ]
      from_port             = 0
      protocol              = "-1"
      to_port               = 0
    } 
    
    ingress {
      cidr_blocks           = [ "88.109.91.55/32", "52.93.153.170/32" ]
      description           = "this rule is for inbound SSH access"
      from_port             = 22
      protocol              = "tcp"
      to_port               = 22
    }

    ingress {
      cidr_blocks           = [ "88.109.91.55/32", "52.93.153.170/32" ]
      description           = "this rule is for inbound HTTP access"
      from_port             = 80
      protocol              = "tcp"
      to_port               = 80
    }

    ingress {
      cidr_blocks           = [ "88.109.91.55/32", "52.93.153.170/32" ]
      description           = "this rule is for inbound HTTPS access"
      from_port             = 443
      protocol              = "tcp"
      to_port               = 443
    } 

    tags = {
        "name"          = "dev_sg_ssh_http_allowed_eu_west2_subhachat"
        "purpose"       = "dev_workspace"
        "provisioner"   = "terraform"
    }
}