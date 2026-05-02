resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.bastion_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags                        = { Name = "${var.project_name}-bastion" }
}

resource "aws_instance" "db" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.db_subnet_id
  vpc_security_group_ids = [var.db_sg_id]
  key_name               = var.key_name

  user_data_base64 = base64encode(<<-EOF
    #!/bin/bash
    echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4
    apt-get update -y
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
    systemctl start mysql
    systemctl enable mysql
  EOF
  )

  tags = { Name = "${var.project_name}-db" }
}
