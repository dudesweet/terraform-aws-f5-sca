
resource "aws_instance" "jumphost" { 
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = var.ec2_key_name
  subnet_id               = var.subnets.value.az1.application.application_region
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags                    = {
    Name = "jumphost"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpcs.value.application

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_http_https" {
  name        = "allow_http_https"
  description = "Allow HTTP and HTTPS inbound traffic"
  vpc_id      = var.vpcs.value.application

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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
    Name = "allow_http_https"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpcs.value.application
  tags = {
    Name = "application"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.jumphost.id
  vpc      = true
}
