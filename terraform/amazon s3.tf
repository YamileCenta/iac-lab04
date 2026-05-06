resource "aws_s3_bucket" "images" {
  bucket = "bucket-${var.project_name}-${local.env}"

  tags = {
    Name        = "${var.project_name}-${local.env}bucket"
    Environment = local.env
  }
}


resource "aws_s3_object" "uploads_folder" {
  bucket = aws_s3_bucket.images.id
  key    = "uploads/"
}

resource "aws_s3_object" "processed_folder" {
  bucket = aws_s3_bucket.images.id
  key    = "processed/"
}


resource "aws_s3_bucket_lifecycle_configuration" "images_lifecycle" {
  bucket = aws_s3_bucket.images.id

  rule {
    id     = "expire-original-images"
    status = "Enabled"
    filter {
      prefix = "uploads/"
    }
    expiration {
      days = 30
    }
  }

  # Regla para la carpeta processed (90 días)
  rule {
    id     = "expire-processed-images"
    status = "Enabled"
    filter {
      prefix = "processed/"
    }
    expiration {
      days = 90
    }
  }
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.images.id

  queue {
    queue_arn     = aws_sqs_queue.image_queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "uploads/"
  }

  depends_on = [aws_sqs_queue_policy.image_queue_policy]
}

