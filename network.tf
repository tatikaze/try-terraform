resource "aws_vpc" "try-hurin" { 
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = "true"
	enable_dns_hostnames = "false"
	tags = {
		Name = "try-hurin"
	}
}

resource "aws_subnet" "public-web" { 
	vpc_id = (aws_vpc.try-hurin.id)
	cidr_block = "10.0.1.0/24"
	availability_zone = "ap-northeast-1a"
	tags = {
		Name = "public-hurin-web"
	}
}

resource "aws_subnet" "private-db-1" { 
	vpc_id = (aws_vpc.try-hurin.id)
	cidr_block = "10.0.2.0/24"
	availability_zone = "ap-northeast-1a"
	tags = {
		Name = "private-hurin-db1"
	}
}

resource "aws_subnet" "private-db-2" { 
	vpc_id = (aws_vpc.try-hurin.id)
	cidr_block = "10.0.3.0/24"
	availability_zone = "ap-northeast-1d"
	tags = {
		Name = "private-hurin-db2"
	}
}

resource "aws_internet_gateway" "try-hurin-gw" { 
	vpc_id = (aws_vpc.try-hurin.id)
	depends_on = [aws_vpc.try-hurin]
	tags = {
		Name = "try-hurin-gw"
	}
}

resource "aws_route_table" "public-route" { 
	vpc_id = (aws_vpc.try-hurin.id)
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = (aws_internet_gateway.try-hurin-gw.id)
	}
	tags = {
		Name = "public-route"
	}
}

# public-subnetを外に出す
resource "aws_route_table_association" "public-a" { 
	subnet_id = (aws_subnet.public-web.id)
	route_table_id = (aws_route_table.public-route.id)
}
