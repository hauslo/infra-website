
resource "aws_s3_bucket_policy" "public_read" {
  policy = data.aws_iam_policy_document.public_read.json
  bucket = aws_s3_bucket.resource.bucket
}

resource "aws_s3_bucket" "resource" {
  bucket = var.id
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "resource" {
  for_each     = fileset(var.public, "**/*.*")
  bucket       = aws_s3_bucket.resource.bucket
  key          = replace(each.value, var.public, "")
  source       = "${var.public}/${each.value}"
  acl          = "public-read"
  etag         = filemd5("${var.public}/${each.value}")
  content_type = element(lookup(local.mimetypes, split(".", each.value)[length(split(".", each.value)) - 1]), 0)
}
