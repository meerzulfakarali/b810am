variable "ami" {
  default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "nvKeys"
}


variable "subnet_id_1a" {
  default = "subnet-072a4db57e7ea0c2e"
}

variable "subnet_id_1b" {
  default = "subnet-0e300d033680c2e1d"
}

variable "iam_instance_profile" {
  default = "SSM-EC2"
}


