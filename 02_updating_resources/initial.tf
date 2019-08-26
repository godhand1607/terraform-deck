
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

resource "aws_s3_bucket" "website_bucket" {
    bucket = "${var.bucket_name}"
    force_destroy = "${var.env == "production" ? false : true}"

    website {
        index_document = "index.html"
        error_document = "index.html"
    }
}
