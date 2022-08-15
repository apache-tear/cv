output "key_pair_name" {
  value = aws_key_pair.kp.key_name
}

output "ec2_ip" {
  value = aws_instance.cv_server.public_ip
}

output "ec2_tags" {
  value = aws_instance.cv_server.tags_all
}

