output {
  # Output the public IP address of the EC2 instance
  instance_public_ip {
	value = aws_instance.web_server.public_ip
	description = "The public IP address of the web server instance"
  }
  # Output the private IP address of the EC2 instance
  instance_private_ip {
	value = aws_instance.web_server.private_ip
	description = "The private IP address of the web server instance"
  }
  # Output the ID of the security group
  security_group_id {
	value = aws_security_group.web_sg.id
	description = "The ID of the security group for the web server"
  }
}