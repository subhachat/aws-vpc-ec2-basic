variable "AWS_REGION" {    
    default = "eu-west-2"
}

variable "AMI" {
    type = map

    default = {
        eu-west-2 = "ami-095c250f1ce4accce" //20.04 LTS
    }
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "EC2_USER" {
  default = "ubuntu"
}

variable "PRIVATE_KEY_PATH" {
  default = "dev_ppk_rsa4k"
}

variable "PUBLIC_KEY_PATH" {
  default = "dev_ppk_rsa4k.pub"
}