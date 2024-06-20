provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "instance" {
  ami                    = "ami-0e001c9271cf7f3b9"
  instance_type          = "t2.micro"
  key_name               = "myKey"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "HTTP",
    tags = "ubuntu"
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
