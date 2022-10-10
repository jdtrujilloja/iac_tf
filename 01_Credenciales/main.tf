resource "aws_iam_role" "aws_iam_role_start_stop_instance" {
  name               = var.aws_iam_role_start_stop_instance
  assume_role_policy = file("policies/iam_role_ec2_start_stop_instance.json")
}
resource "aws_iam_policy" "aws_iam_policy_start_stop_instance" {
  name        = var.aws_iam_policy_start_stop_instance
  description = "Policy generate to start and stop ec2 instance"
  policy      = file("policies/iam_policy_ec2_start_stop_instance.json")
}
resource "aws_iam_policy_attachment" "attach_iam_role_with_policy_start_stop_instance" {
  name       = "attach_iam_role_with_policy_start_stop_instance"
  roles      = ["${aws_iam_role.aws_iam_role_start_stop_instance.name}"]
  policy_arn = aws_iam_policy.aws_iam_policy_start_stop_instance.arn
}
data "archive_file" "aws_lambda_function_start_instance_zip" {
  type        = "zip"
  source_file = "lambda_index_ec2_start_instance.js"
  output_path = "aws_lambda_function_start_instance.zip"
}
data "archive_file" "aws_lambda_function_stop_instance_zip" {
  type        = "zip"
  source_file = "lambda_index_ec2_stop_instance.js"
  output_path = "aws_lambda_function_stop_instance.zip"
}
resource "aws_lambda_function" "aws_lambda_function_start_instance" {
  filename      = "aws_lambda_function_start_instance.zip"
  function_name = var.aws_lambda_function_start_instance
  role          = aws_iam_role.aws_iam_role_start_stop_instance.arn
  handler       = "lambda_index_ec2_start_instance.handler"
  runtime       = "nodejs12.x"
}
resource "aws_lambda_function" "aws_lambda_function_stop_instance" {
  filename      = "aws_lambda_function_stop_instance.zip"
  function_name = var.aws_lambda_function_stop_instance
  role          = aws_iam_role.aws_iam_role_start_stop_instance.arn
  handler       = "lambda_index_ec2_stop_instance.handler"
  runtime       = "nodejs12.x"
}

resource "aws_cloudwatch_event_rule" "aws_cloudwatch_event_rule_start_instance" {
  name                = var.aws_cloudwatch_event_rule_start_instance
  description         = "Lunes-Viernes 08:00"
  schedule_expression = "cron(0 13 ? * MON-FRI *)"
}
resource "aws_cloudwatch_event_rule" "aws_cloudwatch_event_rule_stop_instance" {
  name                = var.aws_cloudwatch_event_rule_stop_instance
  description         = "Lunes-Viernes 18:00"
  schedule_expression = "cron(0 23 ? * MON-FRI *)"
}
resource "aws_cloudwatch_event_target" "aws_cloudwatch_event_target_start_instance" {
  rule      = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_start_instance.name
  target_id = "aws_cloudwatch_event_target_start_instance"
  arn       = aws_lambda_function.aws_lambda_function_start_instance.arn
}
resource "aws_cloudwatch_event_target" "aws_cloudwatch_event_target_stop_instance" {
  rule      = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_stop_instance.name
  target_id = "aws_cloudwatch_event_target_stop_instance"
  arn       = aws_lambda_function.aws_lambda_function_stop_instance.arn
}
resource "aws_lambda_permission" "allow_cloudwatch_lambda_start_instance" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws_lambda_function_start_instance.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_start_instance.arn
}
resource "aws_lambda_permission" "allow_cloudwatch_lambda_stop_instance" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws_lambda_function_stop_instance.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_stop_instance.arn
}


# ------------------------------INACTIVO (CREACION RDS) --------------------------------------

# resource "aws_iam_policy" "aws_iam_policy_juan_s3_read_write" {
#   name        = var.aws_iam_policy_juan_s3_read_write
#   description = "Policy generate to read and write s3 backupt10-trujillo bucket"
#   policy      = file("policies/iam_policy_juan_s3_read_write.json")
# }

# resource "aws_iam_role" "aws_iam_role_start_stop_db" {
#   name               = var.aws_iam_role_start_stop_db
#   assume_role_policy = file("policies/iam_role_ec2_start_stop_db.json")
# }
# resource "aws_iam_policy" "aws_iam_policy_start_stop_db" {
#   name        = var.aws_iam_policy_start_stop_db
#   description = "Policy generate to start and stop rds instance"
#   policy      = file("policies/iam_policy_rds_start_stop_db.json")
# }
# resource "aws_iam_policy_attachment" "attach_iam_role_with_policy_start_stop_db" {
#   name       = "attach_iam_role_with_policy_start_stop_db"
#   roles      = ["${aws_iam_role.aws_iam_role_start_stop_db.name}"]
#   policy_arn = aws_iam_policy.aws_iam_policy_start_stop_db.arn
# }

# data "archive_file" "aws_lambda_function_start_db_zip" {
#   type        = "zip"
#   source_file = "lambda_index_start_rds_db.py"
#   output_path = "aws_lambda_function_start_db.zip"
# }
# data "archive_file" "aws_lambda_function_stop_db_zip" {
#   type        = "zip"
#   source_file = "lambda_index_stop_rds_db.py"
#   output_path = "aws_lambda_function_stop_db.zip"
# }

# resource "aws_lambda_function" "aws_lambda_function_start_db" {
#   filename      = "aws_lambda_function_start_db.zip"
#   function_name = var.aws_lambda_function_start_db
#   role          = aws_iam_role.aws_iam_role_start_stop_db.arn
#   handler       = "lambda_index_start_rds_db.lambda_handler"
#   runtime       = "python3.7"
#   environment {
#     variables = {
#       KEY    = "Name"
#       REGION = "us-east-1"
#       VALUE  = "trujillodb"
#     }
#   }
# }

# resource "aws_lambda_function" "aws_lambda_function_stop_db" {
#   filename      = "aws_lambda_function_stop_db.zip"
#   function_name = var.aws_lambda_function_stop_db
#   role          = aws_iam_role.aws_iam_role_start_stop_db.arn
#   handler       = "lambda_index_stop_rds_db.lambda_handler"
#   runtime       = "python3.7"
#   environment {
#     variables = {
#       KEY    = "Name"
#       REGION = "us-east-1"
#       VALUE  = "trujillodb"
#     }
#   }
# }

# resource "aws_cloudwatch_event_rule" "aws_cloudwatch_event_rule_start_db" {
#   name                = var.aws_cloudwatch_event_rule_start_db
#   description         = "Lunes-Viernes 08:00"
#   schedule_expression = "cron(0 13 ? * MON-FRI *)"
# }
# resource "aws_cloudwatch_event_rule" "aws_cloudwatch_event_rule_stop_db" {
#   name                = var.aws_cloudwatch_event_rule_stop_db
#   description         = "Lunes-Viernes 18:00"
#   schedule_expression = "cron(0 23 ? * MON-FRI *)"
# }
# resource "aws_cloudwatch_event_target" "aws_cloudwatch_event_target_start_db" {
#   rule      = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_start_db.name
#   target_id = "aws_cloudwatch_event_target_start_db"
#   arn       = aws_lambda_function.aws_lambda_function_start_db.arn
# }
# resource "aws_cloudwatch_event_target" "aws_cloudwatch_event_target_stop_db" {
#   rule      = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_stop_db.name
#   target_id = "aws_cloudwatch_event_target_stop_db"
#   arn       = aws_lambda_function.aws_lambda_function_stop_db.arn
# }
# resource "aws_lambda_permission" "allow_cloudwatch_lambda_start_db" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.aws_lambda_function_start_db.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_start_db.arn
# }
# resource "aws_lambda_permission" "allow_cloudwatch_lambda_stop_db" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.aws_lambda_function_stop_db.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_stop_db.arn
# }