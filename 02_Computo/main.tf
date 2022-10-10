resource "aws_vpc" "vpc-juan-trujillo" {
  cidr_block           = "172.60.0.0/16"
  enable_dns_hostnames = true

  tags = {
    "Name" = "vpc-juan-trujillo"
  }
}

resource "aws_subnet" "subnet-juan-trujillo" {


  availability_zone       = "us-east-1a"
  cidr_block              = "172.60.60.0/24"
  vpc_id                  = aws_vpc.vpc-juan-trujillo.id
  map_public_ip_on_launch = true
  tags = {
    "Name" = "subnet-juan-trujillo"
  }
}

resource "aws_subnet" "subnet-rds-us-east-1b" {


  availability_zone       = "us-east-1b"
  cidr_block              = "172.60.61.0/24"
  vpc_id                  = aws_vpc.vpc-juan-trujillo.id
  map_public_ip_on_launch = true
  tags = {
    "Name" = "rds-db-1b"
  }
}

resource "aws_internet_gateway" "ig-juan-trujillo" {
  vpc_id = aws_vpc.vpc-juan-trujillo.id

  tags = {
    Name = "ig-juan-trujillo"
  }
}

resource "aws_route_table" "rt-juan-trujillo" {
  vpc_id = aws_vpc.vpc-juan-trujillo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-juan-trujillo.id
  }

}

resource "aws_route_table_association" "rta-juan-trujillo" {

  subnet_id      = aws_subnet.subnet-juan-trujillo.id
  route_table_id = aws_route_table.rt-juan-trujillo.id
}

resource "aws_route_table_association" "rta-rds-us-east-1b" {

  subnet_id      = aws_subnet.subnet-rds-us-east-1b.id
  route_table_id = aws_route_table.rt-juan-trujillo.id
}

resource "aws_security_group" "juan-trujillo-sec-group" {
  name        = var.name-juan-trujillo-sec-group
  description = "Grupo de seguridad juan-trujillo-sec-group"
  vpc_id      = aws_vpc.vpc-juan-trujillo.id
 ingress {
    description     = "Acceso LAN"
    from_port       = "0"
    to_port         = "0"
    protocol        = "-1"
    cidr_blocks     = []
    self = true
  }
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rules_juan-trujillo-sec-group"
  }
}

resource "aws_key_pair" "windows-key-juan-trujillo" {
  key_name   = "windows-key-juan-trujillo"
  public_key = var.public_key_windows_juan-trujillo
}

resource "aws_eip" "eip_cco" {
  instance = aws_instance.cco-windows-juan-trujillo.id
  vpc      = true
  tags = {
    Name = "ElasticIP_cco"
  }
}

resource "aws_instance" "cco-windows-juan-trujillo" {
  ami                    = "ami-089c0136dad508580"
  instance_type          = "t3a.large"
  availability_zone      = "us-east-1a"
  key_name               = "windows-key-juan-trujillo"
  subnet_id              = aws_subnet.subnet-juan-trujillo.id
  vpc_security_group_ids = ["${aws_security_group.juan-trujillo-sec-group.id}"]
  associate_public_ip_address = true
  #get_password_data      = "true"
  root_block_device {
    volume_size           = "60"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "cco-windows-juan-trujillo"
  }

}

resource "aws_eip" "eip_zonafranca" {
  instance = aws_instance.zonafranca-windows-juan-trujillo.id
  vpc      = true
  tags = {
    Name = "ElasticIP_zonafranca"
  }
}

resource "aws_instance" "zonafranca-windows-juan-trujillo" {
  ami                    = "ami-019e8ed96d96435c1"
  instance_type          = "t3a.large"
  availability_zone      = "us-east-1a"
  key_name               = "windows-key-juan-trujillo"
  subnet_id              = aws_subnet.subnet-juan-trujillo.id
  vpc_security_group_ids = ["${aws_security_group.juan-trujillo-sec-group.id}"]
  associate_public_ip_address = true
  #get_password_data      = "true"
  root_block_device {
    volume_size           = "60"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "zonafranca-windows-juan-trujillo"
  }

}

resource "aws_eip" "eip_carril_zonaf" {
  instance = aws_instance.carril-zonaf-windows-juan-trujillo.id
  vpc      = true
  tags = {
    Name = "ElasticIP_carril_zonafranca"
  }
}

resource "aws_instance" "carril-zonaf-windows-juan-trujillo" {
  ami                    = "ami-02672d12ed39eed1d"
  instance_type          = "t3a.large"
  availability_zone      = "us-east-1a"
  key_name               = "windows-key-juan-trujillo"
  subnet_id              = aws_subnet.subnet-juan-trujillo.id
  vpc_security_group_ids = ["${aws_security_group.juan-trujillo-sec-group.id}"]
  associate_public_ip_address = true
  #get_password_data      = "true"
  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "carril-zonaf-windows-juan-trujillo"
  }

}


resource "aws_eip" "eip_barranquillita" {
  instance = aws_instance.barranquillita-windows-juan-trujillo.id
  vpc      = true
  tags = {
    Name = "ElasticIP_barranquillita"
  }
}

resource "aws_instance" "barranquillita-windows-juan-trujillo" {
  ami                    = "ami-019e8ed96d96435c1"
  instance_type          = "t3a.large"
  availability_zone      = "us-east-1a"
  key_name               = "windows-key-juan-trujillo"
  subnet_id              = aws_subnet.subnet-juan-trujillo.id
  vpc_security_group_ids = ["${aws_security_group.juan-trujillo-sec-group.id}"]
  associate_public_ip_address = true
  #get_password_data      = "true"
  root_block_device {
    volume_size           = "60"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "barranquillita-windows-juan-trujillo"
  }

}

resource "aws_eip" "eip_carril_barranq" {
  instance = aws_instance.carril-barranq-windows-juan-trujillo.id
  vpc      = true
  tags = {
    Name = "ElasticIP_carril_barranq"
  }
}

resource "aws_instance" "carril-barranq-windows-juan-trujillo" {
  ami                    = "ami-02672d12ed39eed1d"
  instance_type          = "t3a.large"
  availability_zone      = "us-east-1a"
  key_name               = "windows-key-juan-trujillo"
  subnet_id              = aws_subnet.subnet-juan-trujillo.id
  vpc_security_group_ids = ["${aws_security_group.juan-trujillo-sec-group.id}"]
  associate_public_ip_address = true
  #get_password_data      = "true"
  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "carril-barranq-windows-juan-trujillo"
  }

}

data "aws_secretsmanager_secret" "private_key_windows_juan-trujillo" {
  arn = var.arn_aws_secretsmanager_secret_private_windows_juan-trujillo
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.private_key_windows_juan-trujillo.id
}



# ------------------------INACTIVO (CREACION RDS) -------------------------------------------------




# resource "aws_db_subnet_group" "rds-trujillo-dev-subnetgroup" {
#   name       = "rds-trujillo-dev-subnetgroup"
#   subnet_ids = [aws_subnet.subnet-juan-trujillo.id,aws_subnet.subnet-rds-us-east-1b.id]

#   tags = {
#     Name       = "rds-trujillo-dev-subnetgroup",
#     Proyect    = "trujillo",
#     Enviroment = "dev"
#   }
# }

# resource "aws_security_group" "rds-trujillo-sec-group" {
#   name        = var.name-rds-trujillo-sec-group
#   description = "Grupo de seguridad rds-trujillo-sec-group"
#   vpc_id      = aws_vpc.vpc-juan-trujillo.id

#   dynamic "ingress" {
#     for_each = var.ingress_rds_rules
#     content {
#       description = ingress.value.description
#       from_port   = ingress.value.from_port
#       to_port     = ingress.value.to_port
#       protocol    = ingress.value.protocol
#       cidr_blocks = ingress.value.cidr_blocks
#     }
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "rules_rds-trujillo-sec-group"
#   }
# }

# resource "random_password" "trujillodb-password" {
#   length           = 16
#   special          = true
#   override_special = "_"
# }
  
# resource "aws_secretsmanager_secret" "secretadminDB-trujillo" {
#    name = "Adminaccountdb-trujillo"
# }
 
# resource "aws_secretsmanager_secret_version" "sversion" {
#   secret_id = aws_secretsmanager_secret.secretadminDB-trujillo.id
#   secret_string = <<EOF
#    {
#     "username": "admin",
#     "password": "${random_password.trujillodb-password.result}"
#    }
# EOF
# }
  
# data "aws_secretsmanager_secret" "secretadminDB-trujillo" {
#   arn = aws_secretsmanager_secret.secretadminDB-trujillo.arn
# }
  
# data "aws_secretsmanager_secret_version" "trujillo-version" {
#   secret_id = data.aws_secretsmanager_secret.secretadminDB-trujillo.arn
# }
  
# locals {
#   trujillodb-credentials = jsondecode(data.aws_secretsmanager_secret_version.trujillo-version.secret_string)
# }

# resource "aws_db_instance" "trujillodb" {
#   identifier        = "trujillodb"
#   allocated_storage = 100
#   license_model     = "license-included"
#   storage_type      = "gp2"
#   engine            = "sqlserver-ex"
#   engine_version    = "15.00.4198.2.v1"
#   instance_class    = "db.t3.small"
#   multi_az          = false
#   username          = local.trujillodb-credentials.username
#   password          = local.trujillodb-credentials.password
#   #storage_encrypted = true
#   vpc_security_group_ids       = [aws_security_group.rds-trujillo-sec-group.id]
#   db_subnet_group_name         = aws_db_subnet_group.rds-trujillo-dev-subnetgroup.id
#   publicly_accessible          = true
#   backup_retention_period      = 3
#   skip_final_snapshot          = true
#   performance_insights_enabled = false
#   option_group_name = aws_db_option_group.sqlserver-rds-optiongroup.name
#   parameter_group_name = aws_db_parameter_group.db-pg-trujillodb.name
#   //deletion_protection = true
#   tags = {
#     Name = "trujillodb"
#   }
# }

# resource "aws_s3_bucket" "s3-bucket-backupt10-trujillo" {
#   bucket = "backupt10-trujillo"
# }

# resource "aws_s3_bucket_acl" "acl_s3_backupt10" {
#   bucket = aws_s3_bucket.s3-bucket-backupt10-trujillo.id
#   acl    = "private"
# }

# resource "aws_s3_bucket_versioning" "versioning_s3_backupt10" {
#   bucket = aws_s3_bucket.s3-bucket-backupt10-trujillo.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_iam_role" "aws_iam_role_rds_s3" {
#   name               = var.aws_iam_role_rds_s3
#   assume_role_policy = file("policies/iam_role_rds_s3.json")
# }

# resource "aws_iam_policy" "aws_iam_policy_rds_s3" {
#   name        = var.aws_iam_policy_rds_s3
#   description = "Policy generate to rds connect to s3"
#   policy      = file("policies/iam_policy_rds_s3.json")
# }
# resource "aws_iam_policy_attachment" "attach_iam_role_with_policy_rds_s3" {
#   name       = "attach_iam_role_with_policy_rds_s3"
#   roles      = ["${aws_iam_role.aws_iam_role_rds_s3.name}"]
#   policy_arn = aws_iam_policy.aws_iam_policy_rds_s3.arn
# }

# resource "aws_db_option_group" "sqlserver-rds-optiongroup" {
#   name                     = "sqlserver-rds-optiongroup"
#   option_group_description = "SQLServerRDSGroup"
#   engine_name              = "sqlserver-ex"
#   major_engine_version     = "15.00"

#   option {
#     option_name = "SQLSERVER_BACKUP_RESTORE"

#     option_settings {
#       name  = "IAM_ROLE_ARN"
#       value = aws_iam_role.aws_iam_role_rds_s3.arn
#     }
    
#   }

# }

# resource "aws_db_option_group" "msdtc-ex-2019-trujillo" {
#   name                     = "msdtc-ex-2019-trujillo"
#   option_group_description = "MSDTC option group for SQL Server EX 2019"
#   engine_name              = "sqlserver-ex"
#   major_engine_version     = "15.00"
# option {
#     option_name = "MSDTC"
#     port = "5000"
#     vpc_security_group_memberships = [aws_security_group.rds-trujillo-sec-group.id]
#     option_settings {
#     name = "AUTHENTICATION"
#     value = "NONE"
#     }
    
#        option_settings {
#     name = "TRANSACTION_LOG_SIZE"
#     value = "4"
#     }

#     option_settings {
#     name = "ENABLE_XA"
#     value = "true"
#     }

#     option_settings {
#     name = "ENABLE_SNA_LU"
#     value = "true"
#     }

#     option_settings {
#     name = "ALLOW_OUTBOUND_CONNECTIONS"
#     value = "true"
#     }

#      option_settings {
#     name = "ALLOW_INBOUND_CONNECTIONS"
#     value = "true"
#     }

#     }
#   }

#   resource "aws_db_parameter_group" "db-pg-trujillodb" {
#   name   = "msdtc-sqlserver-ex-15"
#   family = "sqlserver-ex-15.0"
#   description = "in-doubt xact resolution"

# parameter {
#     name  = "in-doubt xact resolution"
#     value = "1"
#   }
#   }
