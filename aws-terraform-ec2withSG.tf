provider "aws" {
  region     = "us-east-1"
}

resource "aws_security_group" "allow_ssh-sg" {
  name        = "allow_ssh"
  description = "Only allow SSH traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name = "allow_ssh-sg"
  }
}

resource "aws_instance" "test-ec2" {
  ami           = "ami-04681a1dbd79675a5"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh-sg.id}"]
  key_name      = "login"

  tags {
    Name = "Challenge1 SunilSchool"
  }
}