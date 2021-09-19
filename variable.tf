variable "rds_root_user" {
	description = "database root username"
	default = "root"
}

variable "rds_root_pass" {
	description = "database root password"
	default = ""
}

variable "ssh_public_key" {
	description = "public ssh key"
	default = ""
}
