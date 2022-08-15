data "aws_ami" "ubuntu" {
    most_recent = true
    
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/*22.04-amd64-server-*"]
        }

    filter {
            name   = "virtualization-type"
            values = ["hvm"]
        }

    owners = ["099720109477"]
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "${var.pk_name}"
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./'${var.pk_name}'.pem"
  }
}

resource "aws_instance" "cv_server" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    key_name = "${aws_key_pair.kp.key_name}"

    tags = var.tags 
}