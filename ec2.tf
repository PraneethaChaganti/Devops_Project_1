resource "aws_instance" "vm" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  key_name = aws_key_pair.terraform_key.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  tags = {
    Name = "terraform-free-tier-vm"
  }
}