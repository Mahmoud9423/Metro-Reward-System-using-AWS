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

### 2. **Initialize the project**
```bash
terraform init
### 🚀 Quick Deployment

```bash
 terraform plan && terraform apply

Monitoring and Notifications
CloudWatch Alarms track key metrics like CPU utilization.

SNS Topics send alerts to email or SMS when alarms are triggered.

You can customize thresholds and recipients in the Terraform code.

✅ Outputs
After deployment, Terraform provides useful outputs such as:

Load Balancer DNS

Auto Scaling Group name

EC2 instance information




