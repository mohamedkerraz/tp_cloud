provider "aws" {
  region = "eu-west-3"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "main_subnet"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main_igw"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "main_route_table"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "swarm" {
  name_prefix = "swarm-"
  description = "Security group for Docker Swarm cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2377
    to_port     = 2377
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
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5173
    to_port     = 5173
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "swarm_sg"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "myKey"
  public_key = file("./myKey.pub")
}

resource "aws_instance" "manager" {
  ami           = "ami-087da76081e7685da"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.swarm.id]
  associate_public_ip_address = true

  tags = {
    Name = "Docker-Swarm-Manager"
  }
}

resource "aws_instance" "worker" {
  count         = 2
  ami           = "ami-087da76081e7685da"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.swarm.id]
  associate_public_ip_address = true

  tags = {
    Name = "Docker-Swarm-Worker-${count.index + 1}"
  }
}

output "manager_public_ip" {
  value = aws_instance.manager.public_ip
}

output "worker_public_ips" {
  value = [for instance in aws_instance.worker : instance.public_ip]
}

resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    manager_ip = aws_instance.manager.public_ip
    worker_ips = [for instance in aws_instance.worker : instance.public_ip]
  })
  filename = "${path.module}/inventory.yml"
}
