resource "aws_ebs_volume" "volume_a" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-A"
  }
}

resource "aws_ebs_volume" "volume_b" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-B"
  }
}

resource "aws_ebs_volume" "volume_c" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-C"
  }
}

resource "aws_ebs_volume" "volume_d" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-D"
  }
}
