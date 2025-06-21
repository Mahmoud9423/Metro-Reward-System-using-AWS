
# 🛠️ Scalable Web Application using AWS (Terraform)

This project provisions a **scalable and monitored AWS infrastructure** for a dynamic web application using **Terraform**. The architecture is designed to ensure high availability, auto-scaling, monitoring, and alerting.

---

## 📌 Key Features

- 🌐 **Highly Available Web App** using EC2 instances across multiple Availability Zones.
- 🔁 **Auto Scaling Group (ASG)** for dynamic traffic handling.
- ⚖️ **Application Load Balancer (ALB)** to distribute traffic.
- 🔐 **Private Subnets** for EC2 and RDS for enhanced security.
- 📊 **CloudWatch** for monitoring performance and triggering alarms.
- 📣 **SNS (Simple Notification Service)** for alerting via email or SMS.

---

## 🧱 Architecture Overview

![AWS Architecture](https://github.com/Mahmoud9423/Metro-Reward-System-using-AWS/blob/main/AWS%20(3).png)

### Components:
- **Amazon EC2**: Hosts the web servers in private subnets.
- **Auto Scaling Group**: Automatically scales EC2 instances based on demand.
- **Elastic Load Balancer (ALB)**: Routes traffic from users to healthy EC2 instances.
- **Amazon RDS (Multi-AZ)**: Provides a highly available and secure database.
- **NAT Gateway**: Enables private instances to access the internet for updates.
- **Internet Gateway**: Allows public access to the load balancer.
- **IAM Role**: Grants permissions to EC2 instances to interact with AWS services.
- **Amazon CloudWatch**: Collects logs and metrics.
- **Amazon SNS**: Sends notifications based on monitoring alarms.

---

## ⚙️ Terraform Infrastructure as Code

The entire infrastructure is defined using **Terraform**, ensuring reproducibility and scalability.

### 📁 File Structure

```
.
├── main.tf              # Main Terraform configuration
└── README.md            # Project overview
```

---

## 🚀 How to Deploy

### 1. Prerequisites

- Install [Terraform](https://www.terraform.io/downloads)
- Configure AWS CLI with `aws configure`

---

### 2. Deployment Commands

```bash
# Initialize the Terraform configuration
terraform init

# Review changes before applying
terraform plan

# Apply the configuration
terraform apply

# Destroy the infrastructure when done
terraform destroy
```

---

## ✅ Terraform Outputs

After deployment, Terraform provides:

- Application Load Balancer (ALB) DNS name
- Auto Scaling Group name
- EC2 instance details
- RDS endpoint

---

## 📬 Monitoring and Alerts

- **CloudWatch Alarms** monitor key metrics like CPU usage and instance health.
- **SNS Topics** send notifications to your configured email or phone.
- You can customize thresholds and recipients in Terraform files.

---

## 🧑‍💻 Author

**Mahmoud Emad**

> 🌟 Star this repository if you find it useful!
