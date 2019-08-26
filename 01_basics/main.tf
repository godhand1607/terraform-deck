
# VARIABLES

variable "aws_access_key" {
    default = ""
}

variable "aws_secret_key" {
    default = ""
}

variable "private_key_path" {
    default = ""
}

variable "key_name" {
    default = ""
}


# PROVIDERS

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "us-east-1"
}


# RESOURCES

resource "aws_instance" "nginx" {
    ami           = "ami-c58c1dd3"
    instance_type = "t2.micro"
    key_name      = "${var.key_name}"

    connection {
        type        = "ssh"
        host        = self.public_ip
        user        = "ec2-user"
        private_key = "${file(var.private_key_path)}"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo yum install nginx -y",
            "sudo service nginx start"
        ]
    }
}


# OUTPUTS

output "aws_instance_public_dns" {
    value = "${aws_instance.nginx.public_dns}"
}
