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

resource "aws_ec2_instance" "cv_server" {
    ami = aws_ami.ubuntu.id
    instance_type = "t3.micro"
    key_name = ""
}

tags = {
    Name = "cv_server"
}