provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Change this to your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"  # Change this to your desired availability zone

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

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

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}

resource "aws_instance" "tomcat" {
  ami           = "ami-0c7217cdde317cfec"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "Terraform"  # Replace with the name of your key pair

  subnet_id         = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "tomcat"
  }
provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]
provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Change this to your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"  # Change this to your desired availability zone

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

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

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}

resource "aws_instance" "tomcat" {
  ami           = "ami-0c7217cdde317cfec"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "Terraform"  # Replace with the name of your key pair

  subnet_id         = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "tomcat"
  }
provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"  # Adjust the username based on your AMI
      private_key = file("H:/Terraform.pem")  # Adjust the path to your private key
      host        = self.public_ip  # Use self.public_ip to reference the public IP of the instance
    }
  }

resource "aws_ami" "example_ami" {
  name                = "apache-AMI"
  instance_id         = aws_instance.example_instance.id
  no_reboot           = true  # Optional: Indicates whether the instance should be rebooted before creating the AMI
}


}


    connection {
      type        = "ssh"
      user        = "ubuntu"  # Adjust the username based on your AMI
      private_key = file("H:/Terraform.pem")  # Adjust the path to your private key
      host        = self.public_ip  # Use self.public_ip to reference the public IP of the instance
    }
  }

resource "aws_ami" "example_ami" {
  name                = "apache-AMI"
  instance_id         = aws_instance.example_instance.id
  no_reboot           = true  # Optional: Indicates whether the instance should be rebooted before creating the AMI
}

provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Change this to your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"  # Change this to your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"  # Change this to your desired availability zone

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"  # Change this to your desired availability zone

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

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

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}

resource "aws_instance" "public_instance_1" {
  ami           = "ami-xxxxxxxxxxxxxxxxx"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"  # Replace with the name of your key pair

  subnet_id         = aws_subnet.public_subnet_1.id
  security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "public-instance-1"
  }
}

resource "aws_instance" "public_instance_2" {
  ami           = "ami-xxxxxxxxxxxxxxxxx"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"  # Replace with the name of your key pair

  subnet_id         = aws_subnet.public_subnet_2.id
  security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "public-instance-2"
  }
}

resource "aws_lb" "my_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_security_group.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    status_code      = "200"
    content_type     = "text/plain"
    content          = "OK"
  }
}

resource "aws_lb_target_group_attachment" "instance_1_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.public_instance_1.id
}

resource "aws_lb_target_group_attachment" "instance_2_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.public_instance_2.id
}

resource "aws_autoscaling_group" "my_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }

  health_check_type        = "EC2"
  health_check_grace_period = 300
  force_delete              = true
}

resource "aws_launch_template" "my_launch_template" {
  name = "my-launch-template"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
    }
  }

  network_interfaces {
    network_interface_id = aws_instance.public_instance_1.network_interface_ids[0]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "my-instance"
    }
  }
}




}

