resource "aws_internet_gateway" "dev_web" {
    vpc_id = "${aws_vpc.dev_web.id}"
    
    tags = {
        "name"          = "dev_web"
        "purpose"       = "workspace"
        "provisioner"   = "terraform"
    }
}

resource "aws_route_table" "public_dev_web" {
    vpc_id = "${aws_vpc.dev_web.id}"
    
    route {
      cidr_block  = "0.0.0.0/0"
      gateway_id  = "${aws_internet_gateway.dev_web.id}"
    }

    tags = {
        "name"          = "public_dev_web"
        "purpose"       = "workspace"
        "provisioner"   = "terraform"
    }
}

resource "aws_route_table_association" "dev_web" {
    subnet_id       = "${aws_subnet.public_dev_web_a.id}"
    route_table_id  = "${aws_route_table.public_dev_web.id}"
}

data "http" "myip" {
  url = "https://api.ipify.org/"
}

resource "aws_security_group" "dev_web" {
    vpc_id      = "${aws_vpc.dev_web.id}"
    description = "Allow standard & alternate ssh, http, https ports; allow everything outbound"

    ingress {
      from_port     = 22
      to_port       = 22
      protocol      = "tcp"
      cidr_blocks   = [ "${chomp(data.http.myip.body)}/32" ]  
    }
    ingress {
      from_port     = 80
      to_port       = 80
      protocol      = "tcp"
      cidr_blocks   = [ "${chomp(data.http.myip.body)}/32" ]  
    }
    ingress {
      from_port     = 443
      to_port       = 443
      protocol      = "tcp"
      cidr_blocks   = [ "${chomp(data.http.myip.body)}/32" ]  
    }
    ingress {
      from_port     = 8080
      to_port       = 8080
      protocol      = "tcp"
      cidr_blocks   = [ "${chomp(data.http.myip.body)}/32" ]  
    }
    ingress {
      from_port     = 8443
      to_port       = 8443
      protocol      = "tcp"
      cidr_blocks   = [ "${chomp(data.http.myip.body)}/32" ]  
    }
    
    egress {
      from_port     = 0
      to_port       = 0
      protocol      = "-1"
      cidr_blocks   = [ "0.0.0.0/0" ]  
    } 

    tags = {
        "name"          = "dev_web"
        "purpose"       = "workspace"
        "provisioner"   = "terraform"
    }
}