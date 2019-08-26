
# VARIABLES

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "bucket_name" {}

variable "env" {}


# PROVIDERS

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "us-east-1"
}


# RESOURCES

module "bucket" {
    source = "./modules/s3_website"

    name = "${var.bucket_name}"
}


resource "aws_s3_bucket_object" "website_index" {
    bucket          = "${module.bucket.s3_website_id}"
    key             = "index.html"
    source          = "./index.html"
    content_type    = "text/html"
}

resource "aws_s3_bucket_object" "graphic" {
    bucket = "${module.bucket.s3_website_id}"
    key    = "img.jpg"
    source = "./img.jpg"
}

output "S3_BUCKET_ID" {
    value = "${module.bucket.s3_website_id}"
}

output "WEBSITE_URL" {
    value = "${module.bucket.s3_website_url}"
}

