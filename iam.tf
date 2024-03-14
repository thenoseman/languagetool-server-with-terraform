# For "ecs task role" and "ecs task execution role"
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

# Only "ecs task role"
data "aws_iam_policy_document" "allow_cloudwatch" {
  statement {
    effect    = "Allow"
    actions   = ["logs:Create*", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "allow_cloudwatch" {
  name   = "languagetool-allow-cloudwatch"
  policy = data.aws_iam_policy_document.allow_cloudwatch.json
}

# The role for both "ecs task role" and "ecs task execution role"<D-c>
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "languagetool-ecs-assume-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = {
    Name = "languagetool-ecs-assume-role"
  }
}

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = data.aws_iam_policy.ecs_task_execution_role_policy.arn
}

resource "aws_iam_role_policy_attachment" "allow_cloudwatch" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.allow_cloudwatch.arn

}
