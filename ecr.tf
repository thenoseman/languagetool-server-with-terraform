resource "aws_ecr_repository" "languagetool" {
  name = "languagetool"
  tags = {
    Name = "languagetool"
  }
}

resource "null_resource" "languagetool_push_to_ecr" {
  triggers = {
    ecr_repository = aws_ecr_repository.languagetool.arn
    image          = var.languagetool_docker_image_tag
  }

  provisioner "local-exec" {
    command = <<-EOC
      aws ecr get-login-password | docker login --username AWS --password-stdin ${aws_ecr_repository.languagetool.repository_url} 
      docker pull --platform linux/amd64 ${var.languagetool_docker_image}:${var.languagetool_docker_image_tag}
      docker tag ${var.languagetool_docker_image} ${aws_ecr_repository.languagetool.repository_url}:${var.languagetool_docker_image_tag}
      docker push ${aws_ecr_repository.languagetool.repository_url}:${var.languagetool_docker_image_tag}
    EOC
  }

  depends_on = [aws_ecr_repository.languagetool]
}
