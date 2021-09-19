resource "aws_security_group" "private-db-sg" { 
	name = "private-db-sg"
	vpc_id = (aws_vpc.try-hurin.id)
	ingress {
		from_port = 3306
		to_port = 3306
		protocol = "tcp"
		cidr_blocks = ["10.0.1.0/24"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "public-db-sg"
	}
}

resource "aws_db_subnet_group" "private-db-sbg" { 
	name = "private-db-sbg"
	subnet_ids = [(aws_subnet.private-db-1.id),(aws_subnet.private-db-2.id)]
	tags = {
		Name = "private-db-sbg"
	}
}

resource "aws_db_instance" "try_rds" { 
	identifier = "try-rds"
	name = "try_rds"
	allocated_storage = 10
	engine = "mysql"
	engine_version = "8.0"
	instance_class = "db.t3.micro"
	username = (var.rds_root_user)
	password = (var.rds_root_pass)
	db_subnet_group_name = (aws_db_subnet_group.private-db-sbg.name)
	vpc_security_group_ids = [(aws_security_group.private-db-sg.id)]
	skip_final_snapshot = true
}
