# 🛠️ Scalable Web Application using AWS (Terraform)

This project provisions a **scalable and monitored AWS infrastructure** for a dynamic web application using **Terraform**. The architecture is designed to ensure high availability, auto-scaling, monitoring, and alerting.

---

## 📚 Table of Contents

1. [Badges](#badges)  
2. [Key Features](#key-features)  
3. [Architecture Overview](#architecture-overview)  
4. [Terraform Infrastructure as Code](#terraform-infrastructure-as-code)  
5. [How to Deploy](#how-to-deploy)  
6. [Monitoring and Alerts](#monitoring-and-alerts)  
7. [AWS Well-Architected Framework Alignment](#aws-well-architected-framework-alignment)  
8. [Author](#author)

---

## Badges

![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws)
![Status](https://img.shields.io/badge/status-active-brightgreen)


---

## Key Features

- 🌐 **Highly Available Web App** using EC2 instances across multiple Availability Zones.
- 🔁 **Auto Scaling Group (ASG)** for dynamic traffic handling.
- ⚖️ **Application Load Balancer (ALB)** to distribute traffic.
- 🔐 **Private Subnets** for EC2 and RDS for enhanced security.
- 📊 **CloudWatch** for monitoring performance and triggering alarms.
- 📣 **SNS (Simple Notification Service)** for alerting via email or SMS.

---

## Architecture Overview

![AWS Architecture](https://github.com/Mahmoud9423/Metro-Reward-System-using-AWS/blob/main/AWS%20(3).png)

### Components

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

## Terraform Infrastructure as Code

The entire infrastructure is defined using **Terraform**, ensuring reproducibility and scalability.

### File Structure

```
.
├── main.tf          # Main Terraform configuration
└── README.md        # Project overview and guide
```

---

## How to Deploy
### Prerequisites

- Install [Terraform](https://www.terraform.io/downloads)
- Configure AWS CLI with `aws configure`

### Deployment Commands

```bash
# Step 1: Initialize the Terraform configuration
terraform init
```

```bash
# Step 2: Review changes before applying
terraform plan
```

```bash
# Step 3: Apply the configuration
terraform apply
```

```bash
# Step 4: Destroy the infrastructure when done
terraform destroy
```

---

## Monitoring and Alerts

- **CloudWatch Alarms** monitor key metrics like CPU usage and instance health.
- **SNS Topics** send notifications to your configured email or phone.
- You can customize thresholds and recipients in `main.tf`.

---
## 🏗️ AWS Well-Architected Framework Alignment

This project aligns with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/) by addressing the five key pillars:

| Pillar                  | How It’s Addressed                                                                                     |
|-------------------------|--------------------------------------------------------------------------------------------------------|
| **Operational Excellence** | Uses Terraform for repeatable, auditable infrastructure deployments and CloudWatch for monitoring and alerting. |
| **Security**               | EC2 and RDS are in private subnets. IAM roles enforce least-privilege access. No public access to databases.   |
| **Reliability**            | RDS is deployed in Multi-AZ mode, and EC2 instances are in Auto Scaling Groups across multiple Availability Zones. |
| **Performance Efficiency** | Load balancing with ALB and dynamic scaling with ASG ensures efficient use of resources under varying load.     |
| **Cost Optimization**      | Auto Scaling shuts down idle instances. NAT is isolated, and unnecessary public IPs are avoided. Terraform enables visibility and control of resource usage. |

---

## Author

**Mahmoud Emad**

> 🌟 Star this repository if you find it useful!
