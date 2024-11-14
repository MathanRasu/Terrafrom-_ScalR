provider "aws" {
  alias  = "LearningScalR"
  region = "us-east-1"
}

resource "aws_api_gateway_rest_api" "example" {
  name        = "MyAPIGateway"
  description = "API Gateway created with Terraform and Scalr"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "mock_integration" {
  rest_api_id             = aws_api_gateway_rest_api.example.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.get_method.http_method
  type                    = "MOCK"
  integration_http_method = "POST"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = "dev"
}

output "api_url" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}
