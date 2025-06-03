# Metro-Reward-System-using-AWS
# 🛠️ AWS Infrastructure Project – Scalable Web Application (with Terraform)

This project provisions a scalable and monitored AWS infrastructure for a dynamic web application using **Terraform**. It automatically handles load balancing, auto scaling, monitoring, and notifications.

---

## 📦 AWS Services Used

- **Amazon EC2** – Hosts the web servers.
- **Auto Scaling Group** – Automatically adjusts EC2 instance count based on traffic.
- **Elastic Load Balancer (ALB)** – Distributes traffic evenly to EC2 instances.
- **Default VPC & Internet Gateway** – Provides basic networking and public internet access.
- **CloudWatch** – Monitors metrics like CPU usage and instance health.
- **SNS (Simple Notification Service)** – Sends alerts based on CloudWatch alarms.

---

## ⚙️ Infrastructure as Code: Terraform

This infrastructure is fully defined using **Terraform**, allowing for repeatable, version-controlled deployment.

### 📁 Project Structure 

main.tf

---

## 🚀 How to Deploy

### 1. **Prerequisites**
- Install [Terraform](https://www.terraform.io/downloads)
- Configure your AWS credentials (via `aws configure` or environment variables)

### 2. **Commands**

Run the following commands to initialize, plan, apply, destroy, and exit bash:

```bash
terraform init
&& terraform plan
&& terraform apply

# To destroy the infrastructure, run:
terraform destroy

# To exit the bash shell, type:
exit


🔍 Monitoring and Notifications
CloudWatch Alarms monitor key metrics such as CPU utilization.

SNS Topics send alerts via email or SMS when alarms are triggered.

Alarm thresholds and notification recipients can be customized within the Terraform configuration.

✅ Outputs
After deployment, Terraform provides useful outputs, including:

Load Balancer DNS name

Auto Scaling Group name

EC2 instance details





