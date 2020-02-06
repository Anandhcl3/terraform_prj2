provider "aws" {
 region = "ap-south-1" 
}

#terraform {
#  backend "s3" {
#    bucket = "anandlavu"
#    key    = "terraform/dev/jenkins.tfstate"
#    region = "ap-south-1"
#  }
#}

resource "aws_instance" "web" {
  count = var.instance_count
  ami = "ami-0ce933e2ae91880d3"
  user_data = <<-EOF
                #!/bin/bash
                useradd admin
                echo "Test@1110"|passwd --stdin admin
                echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
                sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
                systemctl restart sshd
                EOF

  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0e1a2934aab4c6270"]
  tags = {
  Name = "${var.env}_web_${count.index}"
  Env  = var.env
  }
}
#output "Private-ip" {
#value = aws_instance.web.*.private_ip
#}
#output "Pulic-ip" {
#value = aws_instance.web.*.public_ip
#}

