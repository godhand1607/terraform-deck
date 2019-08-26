
# VARIABLES

variable "name" {}


# RESOURCES

resource "aws_s3_bucket" "website_bucket" {
    bucket = "${var.name}"
    force_destroy = "true"

    website {
        index_document = "index.html"
        error_document = "index.html"
    }
}

resource "aws_s3_bucket_policy" "website_policy" {
    bucket = "${aws_s3_bucket.website_bucket.id}"

    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.website_bucket.arn}/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "website_access" {
    bucket = "${aws_s3_bucket.website_bucket.id}"

    block_public_acls       = true
    ignore_public_acls      = true
    block_public_policy     = false
    restrict_public_buckets = false
    depends_on              = ["aws_s3_bucket_policy.website_policy"]
}


# OUTPUTS

output "s3_website_id" {
    value = "${aws_s3_bucket.website_bucket.id}"
}

output "s3_website_url" {
    value = "http://${aws_s3_bucket.website_bucket.website_endpoint}"
}

