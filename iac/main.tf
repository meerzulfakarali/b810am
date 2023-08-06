# Versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Providers
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}


# Resource_1

resource "aws_instance" "efs_1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id_1a
  vpc_security_group_ids = ["sg-02fbadd90b40fcf6d"]
  iam_instance_profile   = var.iam_instance_profile
  #user_data              = file("/Users/ck/repos/iac-terraform/iac/web.sh")
  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install apache2 -y
  sudo apt-get -y install git binutils
  cd /opt/
  git clone https://github.com/aws/efs-utils
  cd /opt/efs-utils
  bash /opt/efs-utils/build-deb.sh
  sudo apt-get -y install ./build/amazon-efs-utils*deb
  systemctl status rpcbind.service
  echo "Welcome To EFS DEMO Iam Server 1 hostname " > /var/www/html/index.html
  sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0602434df4d5403d6.efs.us-east-1.amazonaws.com:/ /var/www/html
  EOF

  tags = {
    Name        = "efs Instance_1"
    Environment = "Dev"
    ProjectName = "Cloud Binary"
    ProjectID   = "2023"
    CreatedBy   = "IaC Terraform"
  }
}

# Resource_2

resource "aws_instance" "efs_2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id_1b
  vpc_security_group_ids = ["sg-02fbadd90b40fcf6d"]
  iam_instance_profile   = var.iam_instance_profile
  #user_data              = file("/Users/ck/repos/iac-terraform/iac/web.sh")
  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install apache2 -y
  sudo apt-get -y install git binutils
  cd /opt/
  git clone https://github.com/aws/efs-utils
  cd /opt/efs-utils
  ./opt/efs-utils/build-deb.sh
  sudo apt-get -y install ./build/amazon-efs-utils*deb
  systemctl status rpcbind.service
  echo "Welcome To EFS DEMO Iam Server 2 'hostname' " > /var/www/html/index.html
  sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0602434df4d5403d6.efs.us-east-1.amazonaws.com:/ /var/www/html
  EOF

  tags = {
    Name        = "efs Instance_2"
    Environment = "Dev"
    ProjectName = "Cloud Binary"
    ProjectID   = "2023"
    CreatedBy   = "IaC Terraform"
  }
}

# Outputs
output "ami_ec1" {
  value = aws_instance.efs_1.ami
}
output "public_ip_ec1" {
  value = aws_instance.efs_1.public_ip
}
output "private_ip_ec1" {
  value = aws_instance.efs_1.private_ip
}

output "ami_ec2" {
  value = aws_instance.efs_2.ami
}
output "public_ip_ec2" {
  value = aws_instance.efs_2.public_ip
}
output "private_ip_ec2" {
  value = aws_instance.efs_2.private_ip
}
