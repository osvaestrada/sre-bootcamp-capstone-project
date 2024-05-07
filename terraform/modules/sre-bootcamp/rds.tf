# resource "aws_db_instance" "sre-bootcamp-db" {
#   identifier        = "sremysqldb-${var.env}"
#   storage_type      = "gp2"
#   allocated_storage = 20

#   engine              = "mysql"
#   engine_version      = "8.0"
#   instance_class      = "db.t2.micro"
#   port                = "3306"
#   publicly_accessible = false

#   username            = var.username
#   password            = var.password
#   skip_final_snapshot = true
# }