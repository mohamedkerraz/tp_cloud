resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-087da76081e7685da"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "MyEC2Instance"
  }
}

resource "ansible_host" "my_ec2_instance" {
  name   = "my_ec2_instance"
  groups = ["aws"]

  variables = {
    hostname                     = "my_ec2_instance"
    ansible_user                 = "admin"
    ansible_host                 = aws_instance.my_ec2_instance.public_ip
    ansible_ssh_private_key_file = var.private_key_path
  }
}