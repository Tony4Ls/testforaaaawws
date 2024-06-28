# EBS Volume A
resource "aws_ebs_volume" "volume_a" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-A"
  }
}

# EBS Volume B
resource "aws_ebs_volume" "volume_b" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-B"
  }
}

# EBS Volume C
resource "aws_ebs_volume" "volume_c" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-C"
  }
}

# EBS Volume D
resource "aws_ebs_volume" "volume_d" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-D"
  }
}
