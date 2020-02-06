output "Private-ip" {
value = aws_instance.web.*.private_ip
}
output "Pulic-ip" {
value = aws_instance.web.*.public_ip
}
