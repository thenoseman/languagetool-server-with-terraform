resource "aws_cloudwatch_log_group" "cluster" {
  name              = "/languagetool/cluster"
  retention_in_days = 5
}

resource "aws_ecs_cluster" "languagetool" {
  name = "languagetool"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.cluster.name
      }
    }
  }
}

resource "aws_ecs_service" "languagetool" {
  name            = "languagetool"
  cluster         = aws_ecs_cluster.languagetool.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.languagetool.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    assign_public_ip = true # to pull images without the VPC endpoint hassle
  }

  force_new_deployment = true
  # triggers = {
  #   newplan = plantimestamp()
  # }

  load_balancer {
    target_group_arn = aws_lb_target_group.languagetool.arn
    container_name   = "languagetool"
    container_port   = local.languagetool_port
  }
}

resource "aws_ecs_task_definition" "languagetool" {
  family                   = "languagetool"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  ephemeral_storage {
    size_in_gib = 30 # ngrams need more space
  }

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "languagetool"
      image     = "${aws_ecr_repository.languagetool.repository_url}:${var.languagetool_docker_image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = local.languagetool_port
          hostPort      = local.languagetool_port
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"  = "ecs",
          "awslogs-region" = "eu-central-1",
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" = "languagetool"
        }
      }

      environment = [
        {
          name  = "download_ngrams_for_langs"
          value = join(",", var.languages)
        },
        {
          name  = "langtool_languageModel"
          value = "/tmp"
        },
        {
          name  = "langtool_fasttextModel"
          value = "/tmp/lid.176.bin"
        }
      ]
    }
  ])
}
