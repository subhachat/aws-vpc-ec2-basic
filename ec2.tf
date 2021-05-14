resource "aws_instance" "dev_linuxserver_eu_west2_subhachat" {
    ami                       = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type             = "${var.INSTANCE_TYPE}"
    subnet_id                 = "${aws_subnet.dev_public_subnet01_eu_west2a_subhachat.id}"
    vpc_security_group_ids    = [ "${aws_security_group.dev_sg_ssh_http_allowed_eu_west2_subhachat.id}" ]

    key_name                  = "${aws_key_pair.dev_ppk_rsa4k_eu_west2_subhachat.id}"

    #NGINX installation
    provisioner "remote-exec" {
        inline = [
            "sudo apt update > /dev/null",
            "sudo apt-get -y install nginx "
        ]    
    }

    connection {
        type        = "ssh"
        user        = "${var.EC2_USER}"
        host        = "${self.public_ip}"
        private_key = "${file(var.PRIVATE_KEY_PATH)}"
    }
}

resource "aws_key_pair" "dev_ppk_rsa4k_eu_west2_subhachat" {
    key_name    = "dev_ppk_rsa4k_eu_west2_subhachat"
    public_key  = "${file(var.PUBLIC_KEY_PATH)}"
}