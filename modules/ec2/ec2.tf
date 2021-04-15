resource "aws_instance" "nginx" {
    ami             = "ami-07a0844029df33d7d"
    instance_type   = var.instance_type
    key_name        = "test_key"
    subnet_id       = var.private_subnet_a_id
    security_groups = [var.vpc_security_group_id]
    user_data = file("/mnt/c/terraform-vpc/test.sh")
    root_block_device {

        volume_size = 8 
        volume_type = "gp2"
    }

    tags = {
    Name = "Nginx_server"
  }
    
}