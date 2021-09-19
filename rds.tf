resource "aws_db_instance" "try_rds" { 
	identifier = "try-rds"
	name = "try_rds"
	allocated_storage = 10
	engine = "mysql"
	engine_version = "8.0"
	instance_class = "db.t3.micro"
	username = var.rds_root_user
	password = var.rdb_root_password
	skip_final_snapshot = true
}
