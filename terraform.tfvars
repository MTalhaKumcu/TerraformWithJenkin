ami_id              = "ami-08a0d1e16fc3f61ea"
key_name            = "internforawsKey"
subnet_id           = "subnet-0961bdd70de4edee9"
security_group_name = "EC2-sec-gr"
tags = {
  Name        = "Jenskins-Server"
  Environment = "Jenkins-dev"
  Project     = "Server-Project"
}
ports = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

ssh_ports = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
