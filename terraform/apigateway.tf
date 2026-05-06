# HTTP API
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${var.project_name}-${local.env}"
  protocol_type = "HTTP"

  # CONFIGURACION DE \nCors
  cors_configuration {
    allow_origins = ["*"] 
    allow_methods = ["POST", "OPTIONS"] 
    allow_headers = ["content-type", "authorization"]
    max_age       = 300
  }
}


# INTEGRACION \nProtocol format 2.0
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.upload.invoke_arn

  # CONFIGURACION DE \nPayload 
  payload_format_version = "2.0" 
}


# CONFIGURACION DE \nRoute para POST /upload
resource "aws_apigatewayv2_route" "upload_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /upload"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}


# CONFIGURACION DE \nStage 
resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true

  # CONFIGURACION DE \nThrottling
  default_route_settings {
    throttling_burst_limit = 5000
    throttling_rate_limit  = 10000
  }

  # CONFIGURACION DE \nAccess logs para Cloudwatch
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_logs.arn
    format          = jsonencode({
      requestId      = "$context.requestId"
      sourceIp       = "$context.identity.sourceIp"
      protocol       = "$context.protocol"
      status         = "$context.status"
      responseLength = "$context.responseLength"
      error          = "$context.authorizer.error"
    })
  }
}

# LOG GROUP(API)
resource "aws_cloudwatch_log_group" "api_logs" {
  # Nombre estandarizado siguiendo tu estructura de carpetas
  name              = "/aws/vendedlogs/${var.project_name}-${local.env}-api-logs"
  retention_in_days = 7 # Aumentado a 7 para tener algo de historial
}