variable "region" {
  description = "us-east-1-N.Virginia"
  type        = string
  default     = "us-east-1"
}
variable "instance_type" {
  description = "ec2-t2micro"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "free-tier amazon-linux2"
  type        = string
}
variable "subnet_id" {
  description = "instance will be deployed the subnet"
  type        = string
}
variable "key_name" {
  description = "KeyName"
  type        = string
}

variable "tags" {
  description = "owner"
  type        = map(string)
  default = {
    "name" = "Key-Name-Owner"
  }
}
variable "security_group_name" {
  description = "Ec2-Sec-Gr"
  type        = string
}
variable "ports" {
  description = "List of ports open"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

}
variable "ssh_ports" {
  description = "List of SSH ports to open"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
