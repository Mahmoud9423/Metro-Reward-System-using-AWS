provider "aws" {
  region = "me-central-1"
}

# Get default VPC and subnets
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group allowing HTTP and SSH
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Role with admin access
resource "aws_iam_role" "ec2_admin_role" {
  name = "ec2-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.ec2_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_admin_role.name
}

# Latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Launch Template using IAM instance profile
resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  key_name      = "EC2TUtorial"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd

              cat <<EOT > /var/www/html/index.html
              <!DOCTYPE html>
              <html lang="en">
              <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <title>STEP 2 EARN</title>
                <style>
                  body {
                    background-color:rgb(224, 250, 224);
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    color: #004d40;
                    max-width: 600px;
                    margin: 40px auto;
                    padding: 20px;
                    box-shadow: 0 0 10px rgba(0,0,0,0.1);
                    border-radius: 8px;
                    text-align: center;
                  }
                  h1 {
                    color: #00796b;
                    margin-bottom: 30px;
                  }
                  input[type="text"] {
                    padding: 10px;
                    font-size: 16px;
                    width: 80%;
                    margin-bottom: 20px;
                    border: 1px solid #004d40;
                    border-radius: 4px;
                  }
                  button {
                    background-color: #00796b;
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    font-size: 16px;
                    cursor: pointer;
                    border-radius: 4px;
                    transition: background-color 0.3s ease;
                  }
                  button:hover {
                    background-color: #004d40;
                  }
                  #points {
                    margin-top: 20px;
                    font-size: 20px;
                    font-weight: bold;
                    color: #004d40;
                  }
                  #redeem-section {
                    margin-top: 30px;
                  }
                  select {
                    padding: 10px;
                    font-size: 16px;
                    border-radius: 4px;
                    border: 1px solid #004d40;
                    margin-bottom: 10px;
                    width: 60%;
                  }
                  p {
                    margin: 10px 0;
                  }
                </style>
              </head>
              <body>
                <h1>⚡ Metro Reward System ⚡</h1>
                <p>Enter your ticket number to start earning points for your footsteps in the metro.</p>
                
                <input type="text" id="ticketNumber" placeholder="Enter Ticket Number" />
                <br />
                <button onclick="startTracking()">Start Tracking Footsteps</button>
                
                <div id="points" style="display:none;">
                  Points Earned: <span id="pointsValue">0</span>
                </div>
                
                <div id="redeem-section" style="display:none;">
                  <h3>Redeem Your Points</h3>
                  <select id="redeemOptions">
                    <option value="cashback">Cashback</option>
                    <option value="metro_ticket">Metro Ticket</option>
                  </select>
                  <br />
                  <button onclick="redeemPoints()">Redeem</button>
                  <p id="redeemMessage"></p>
                </div>
                
                <script>
                  let points = 0;
                  let tracking = false;
                  let ticket = "";

                  function startTracking() {
                    const ticketInput = document.getElementById('ticketNumber').value.trim();
                    if (ticketInput === "") {
                      alert("Please enter a valid ticket number.");
                      return;
                    }
                    ticket = ticketInput;
                    points = 50; // constant 50 points instead of 0
                    tracking = true;
                    document.getElementById('pointsValue').textContent = points;
                    document.getElementById('points').style.display = "block";
                    document.getElementById('redeem-section').style.display = "block";
                    alert('Tracking started for ticket: ' + ticket);
                  }

                  function redeemPoints() {
                    if (points === 0) {
                      alert("You have no points to redeem.");
                      return;
                    }
                    const option = document.getElementById('redeemOptions').value;
                    let message = "";
                    if (option === "cashback") {
                      message = "You have redeemed " + points + " points for cashback. Thank you!";
                    } else if (option === "metro_ticket") {
                      message = "You have redeemed " + points + " points for metro tickets. Enjoy your ride!";
                    }
                    alert(message);
                    document.getElementById('redeemMessage').textContent = message;
                    points = 0;
                    document.getElementById('pointsValue').textContent = points;
                  }

                  document.getElementById("ticketNumber").addEventListener("keyup", function(e) {
                    if (e.key === "Enter") {
                      startTracking();
                    }
                  });
                </script>
              </body>
              </html>
              EOT
              EOF
  )
}

# Target Group for ALB
resource "aws_lb_target_group" "web_tg" {
  name     = "pezio-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
  }
}

# Application Load Balancer
resource "aws_lb" "web_alb" {
  name               = "pezio-alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.web_sg.id]
}

# ALB Listener
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = data.aws_subnets.default.ids

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web_tg.arn]
  health_check_type = "ELB"
}

# SNS Topic for Alerts
resource "aws_sns_topic" "alert_topic" {
  name = "pezio-alert-topic"
}

# SNS Email Subscription
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alert_topic.arn
  protocol  = "email"
  endpoint  = "Mahmoudemad1277@gmail.com"
}

# CloudWatch Metric Alarm for CPU Utilization on ASG instances
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name                = "pezio-high-cpu"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                   = 100
  statistic                 = "Average"
  threshold                = 70
  alarm_description        = "This alarm triggers when EC2 CPU utilization is above 70% for 4 minutes"
  alarm_actions            = [aws_sns_topic.alert_topic.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }
}

# Output public URL of website
output "website_url" {
  value       = "http://${aws_lb.web_alb.dns_name}"
  description = "Public URL of Pezio Electric Footstep Power website"
}
