resource "aws_ebs_volume" "volume_a" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "moodle-ebs-us-east-1a"
  }
}

resource "aws_ebs_volume" "volume_b" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "moodle-ebs-us-east-1b"
  }
}

resource "aws_ebs_volume" "volume_a" {
  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp2"
  tags = {
    Name = "mariadb-ebs-us-east-1a"
  }
}

resource "aws_ebs_volume" "volume_b" {
  availability_zone = "us-east-1b"
  size              = 10
  type              = "gp2"
  tags = {
    Name = "mariadb-ebs-us-east-1b"
  }
}
