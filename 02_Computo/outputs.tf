# output "MSSQL_endpoint" {
#   value = "${aws_db_instance.trujillodb.address}"
# }

output "Windows-juan-trujillo-user" {
  value = "Administrator"
}

# output "cco-windows-juan-trujillo-password" {
#   value = rsadecrypt(aws_instance.cco-windows-juan-trujillo.password_data, data.aws_secretsmanager_secret_version.current.secret_string)
#   sensitive = true
# }

output "cco-windows-juan-trujillo-public_ip" {
  value = aws_instance.cco-windows-juan-trujillo.*.public_ip
}

# output "zonafranca-windows-juan-trujillo-password" {
#   value = rsadecrypt(aws_instance.zonafranca-windows-juan-trujillo.password_data, data.aws_secretsmanager_secret_version.current.secret_string)
#   sensitive = true
# }

output "zonafranca-windows-juan-trujillo-public_ip" {
  value = aws_instance.zonafranca-windows-juan-trujillo.*.public_ip
}

# output "carril-zonaf-windows-juan-trujillo-password" {
#   value = rsadecrypt(aws_instance.carril-zonaf-windows-juan-trujillo.password_data, data.aws_secretsmanager_secret_version.current.secret_string)
#   sensitive = true
# }

output "carril-zonaf-windows-juan-trujillo-public_ip" {
  value = aws_instance.carril-zonaf-windows-juan-trujillo.*.public_ip
}

# output "barranquillita-windows-juan-trujillo-password" {
#   value = rsadecrypt(aws_instance.barranquillita-windows-juan-trujillo.password_data, data.aws_secretsmanager_secret_version.current.secret_string)
#   sensitive = true
# }

output "barranquillita-windows-juan-trujillo-public_ip" {
  value = aws_instance.barranquillita-windows-juan-trujillo.*.public_ip
}

# output "carril-barranq-windows-juan-trujillo-password" {
#   value = rsadecrypt(aws_instance.carril-barranq-windows-juan-trujillo.password_data, data.aws_secretsmanager_secret_version.current.secret_string)
#   sensitive = true
# }

output "carril-barranq-windows-juan-trujillo-public_ip" {
  value = aws_instance.carril-barranq-windows-juan-trujillo.*.public_ip
}