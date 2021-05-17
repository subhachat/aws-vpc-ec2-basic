resource "aws_instance" "dev_ubuntu_01" {
    ami                     = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type           = "${var.INSTANCE_TYPE}"
    subnet_id               = "${aws_subnet.public_dev_web_a.id}"
    vpc_security_group_ids  = [ "${aws_security_group.dev_web.id}" ]
    key_name                = "${aws_key_pair.dev_ppk_rsa4k.id}"

    root_block_device {
      volume_type = "gp2"
      volume_size = 30

      tags = {
        "name" = "dev_ubuntu_01_root"
      }
    }

    # NGINX installation
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

    tags = {
        "name"          = "dev_web"
        "purpose"       = "workspace"
        "provisioner"   = "terraform"
    }
}

resource "aws_key_pair" "dev_ppk_rsa4k" {
    key_name    = "dev_ppk_rsa4k"
    public_key  = "${file(var.PUBLIC_KEY_PATH)}"
}