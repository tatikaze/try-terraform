resource "aws_security_group" "public-web-sg" { 
	name = "public-web-sg"
	vpc_id = (aws_vpc.try-hurin.id)
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "public-web-sg"
	}
}

resource "aws_key_pair" "hurin-key" { 
	key_name = "hurin-key"
	public_key = (var.ssh_public_key)
}

resource "aws_instance" "stepping_web" { 
	ami = "ami-02892a4ea9bfa2192"
	instance_type = "t3.micro"
	vpc_security_group_ids = [
		aws_security_group.public-web-sg.id
	]
	subnet_id = (aws_subnet.public-web.id)
	key_name = (aws_key_pair.hurin-key.key_name)
	associate_public_ip_address = true
	ebs_block_device {
		device_name = "/dev/xvda"
		volume_type = "gp2"
		volume_size = 20
	}
	user_data = (file("./clout-init.tpl"))
	tags = {
		Name = "webserver"
	}
}

# resource "aws_eip" "try-hurin-ip" { 
# 	instance = (aws_instance.stepping_web.id)
# 	vpc = true
# }

output "public_ip_of_webserver" {
	value = aws_instance.stepping_web.public_ip
}
