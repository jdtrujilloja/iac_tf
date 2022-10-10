name-juan-trujillo-sec-group = "juan-trujillo-sec-group"

ingress_rules = [	
	{
	    description = "Acceso por ICMP"
    	from_port = "-1"
		to_port = "-1"
		protocol = "icmp"
		cidr_blocks = ["0.0.0.0/0"]
	},
	{
	    description = "Acceso por RDP"
    	from_port = "3389"
		to_port = "3389"
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}    
	]

public_key_windows_juan-trujillo = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+jUPJsZGRgcF7T8bWm//D69H/LlvdtHv4vewk5+5AGW8bfbA4SnMcWKTpOmj9eSdpu2X5xPBjPTVc3mFFRuk8oj2KqwMK8JEzRAb6//B1+DGy0LT7jQQ+m4K4VKrxQX3jFuIwE/XhQrzLjwDVZAN3n2ucElEMFZkfGsAPBCfHJ+1iWd9B96erPeMBt0b8Zn+6fRi2R0TJ56Tm4YieTGbBX7DmIM9g8ZBGuzo6KX440JeeEt5chZZGZljr+Gr4qXnK9xzSlQlfk9rEe+RHNWClM19s7b13k9UAl/w0l9xRF+41iYw8r08JQeu+rzxG901q+s1SOpNCbDNYXfQrqg/ttLwQXDiGRVxBmMTIrO9q3VBAsIFaUutfAyOazggppBxYfDznzOYw+1mU4wY//UMUTViODjI34TpIInNiWM5x9GsfTEQgq9SnqXXMCwW7FjdYvLICnZRfbdkTIZvEwZc0nLBuOGg4f+rWZn7a/HMXiuCVQsm08Wp5HcGUPG6uSRk= juan.trujillo@MacBook-Air-de-Juan.local"

arn_aws_secretsmanager_secret_private_windows_juan-trujillo = "arn:aws:secretsmanager:us-east-1:570962416493:secret:private_key_windows_juan-trujillo-5LWokc"


# ----------------------------- INACTIVO (CREACION RDS) ----------------------------------------------

# ingress_rds_rules = [	
# 	{
# 	    description = "Acceso SMSS"
#     	from_port = "1433"
# 		to_port = "1433"
# 		protocol = "TCP"
# 		cidr_blocks = ["0.0.0.0/0"]
# 	}    
# 	]

# name-rds-trujillo-sec-group = "rds-trujillo-sec-group"
# aws_iam_role_rds_s3 = "iam_role_rds_s3"
# aws_iam_policy_rds_s3 = "iam_policy_rds_s3"