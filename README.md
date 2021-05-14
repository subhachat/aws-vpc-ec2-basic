# Creating a basic AWS VPC setup

## Purpose

To host an NGINX web server on an EC2 instance

### Components

Note - Default region is London

* VPC
* Single subnet
* IGW
* ROUTE
* Security Group to allow ssh(tcp:22), http(tcp:80), https(tcp:443)
* Creating a Key-pair, using local PPK files
* EC2 instance with Ubuntu 20.04 AMI
* NGinx provisioning after instance creation
