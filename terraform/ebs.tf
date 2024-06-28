resource "aws_ebs_volume" "volume_a" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-us-east-1a"
  }
}

resource "aws_ebs_volume" "volume_b" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-us-east-1b"
  }
}

resource "aws_ebs_volume" "volume_c" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs2-us-east-1a"
  }
}

resource "aws_ebs_volume" "volume_d" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs2-us-east-1b"
  }
}
