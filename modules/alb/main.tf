# ALB REQUIRES:
# 1. The Target Group
# 2. Security Group
# 3. Elastic Load Balancer
# 4. Listener Rule
######################## AWS ALB Target Group #######################
resource "aws_lb_target_group" "main" {
  name     = replace(local.name, "rtype", "tg")
  port     = 80
  vpc_id   = var.vpc_id
  protocol = "HTTP"
  health_check {
    path = "/"
    port = var.app_port
  }
  tags = merge(local.common_tags, { Name = replace(local.name, "rtype", "target_group_main") })
}
######################## Application Load Balancer ####################
resource "aws_lb" "main" {
  name               = replace(local.name, "rtype", "lb")
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets
  #for each is a meta argument like count
  #for is a for loop
}
##################### Application Load Balancer Listener ###############
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.app_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}