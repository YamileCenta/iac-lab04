resource "aws_sqs_queue" "image_dlq" {
  name = "image-processor-${local.env}-image-dlq"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "terraform-example-deadletter-queue"
}



resource "aws_sqs_queue" "image_queue" {
  name                      = "image-processor-${local.env}-image-queu"
  visibility_timeout_seconds = 360
  message_retention_seconds = 86400
  receive_wait_time_seconds = 20
  
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.image_dlq.arn
    maxReceiveCount     = 3
    })

  tags = {
    Environment = "${local.env}"
    Project = var.project_name
  }
}

resource "aws_sqs_queue_policy" "image_queue_policy" {
  queue_url = aws_sqs_queue.image_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.image_queue.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_s3_bucket.images.arn
          }
        }
      }
    ]
  })
}
