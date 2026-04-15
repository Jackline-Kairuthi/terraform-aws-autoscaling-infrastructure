# Terraform AWS Auto Scaling Infrastructure
A production‑grade AWS infrastructure deployment built entirely with Terraform, featuring a multi‑AZ VPC, public subnets, an Application Load Balancer, an Auto Scaling Group, Launch Templates, S3 access logging, DynamoDB state locking, and a fully automated EC2 bootstrap process. This project demonstrates real‑world cloud engineering practices, operational maturity, and Infrastructure‑as‑Code discipline.

<h1/>🚀 Project Overview </h1>
This repository provisions a highly available, scalable web tier on AWS. The environment automatically launches EC2 instances across multiple Availability Zones, registers them behind an Application Load Balancer, and serves a confirmation page via user_data.

The design mirrors what you would find in a modern production environment:

- Multi‑AZ VPC architecture

- Public subnets with IGW routing

- Internet‑facing ALB with health checks

- Auto Scaling Group with Launch Template

- Lifecycle hooks for graceful termination

- S3 bucket for ALB access logs

- DynamoDB table for Terraform state locking

- Secure, least‑privilege security groups

- Fully automated Apache installation and HTML deployment

<h1/>🧱 Architecture Summary</h1>

Core Components
- VPC: 10.0.0.0/16

- Subnets: 4 public subnets across 4 AZs

- Routing: IGW + public route table

- Compute: EC2 instances via Launch Template

- Scaling: ASG (min 2, max 4, desired 4)

- Load Balancing: ALB + Target Group + Listener

- State Management: S3 + DynamoDB

- Security: SGs with controlled inbound rules

- Bootstrap: Apache + HTML served via user_data

<h1/> ⚙️ Key Features </h1>

1. Highly Available Networking
   
- Four public subnets across four Availability Zones

- Internet Gateway + public route table

- Automatic public IP assignment

2. Application Load Balancer
   
- Internet‑facing ALB

- HTTP listener on port 80

- Health checks on

- Access logs delivered to S3

3. Auto Scaling Group
   
- Launch Template with Ubuntu AMI

- Automated Apache installation via user_data

- Multi‑AZ instance distribution

- Lifecycle hook for termination events

4. Terraform State Management

- S3 bucket for remote state

- DynamoDB table for state locking

5. Security Best Practices

- ALB open to the internet on port 80

- Instances only accept traffic from inside the VPC

- SSH restricted to VPC CIDR

- Outbound traffic is fully open for updates and package installs

<h1/>🖥️ Demo Output </h1>
When the ALB is deployed successfully, visiting the DNS name displays:
<img width="727" height="206" alt="image" src="https://github.com/user-attachments/assets/7136a9cf-eb50-498d-be51-b5843b3bbe59" />

This confirms:

- ALB is reachable

- The target group is healthy

- Instances bootstrapped correctly

- ASG is functioning

<h1/>📸 Screenshots </h1>

<h1/>Load balancer</h1>
<img width="1813" height="764" alt="image" src="https://github.com/user-attachments/assets/ac8afc6e-4319-4727-ac28-4e942f74131b" />

<h1/>Target group showing 4/4 healthy instances</h1>
<img width="1090" height="712" alt="image" src="https://github.com/user-attachments/assets/ea833f01-5eea-40dd-91a6-e9213db43a40" />

<h1/>Auto Scaling Group activity</h1>
<img width="1512" height="782" alt="image" src="https://github.com/user-attachments/assets/229b654c-355e-4b20-b4cb-e78d163e916b" />

<h1/>S3 bucket with ALB logs</h1>
<img width="1507" height="808" alt="image" src="https://github.com/user-attachments/assets/7b2d5df5-4cfd-407f-8c88-b50617a55a6f" />

<h1/>DynamoDB lock table</h1>
<img width="1722" height="849" alt="image" src="https://github.com/user-attachments/assets/0012400a-7c50-4c2d-a116-cfad7a0746cb" />
<img width="1604" height="897" alt="image" src="https://github.com/user-attachments/assets/88a061b0-e1a6-4647-860a-f0b891d6a24a" />

<h1/>🛠️ Deployment Instructions </h1>
From the terraform/ directory:

Code
- terraform init
- terraform plan 
- terraform apply -auto-approve
- Retrieve the ALB DNS:

Code
- terraform output load_balancer_dns_name
- Open it in your browser.

<h1/>📌 Future Enhancements </h1>
- Add HTTPS with ACM + HTTPS listener

- Add CloudWatch alarms and scaling policies

- Add private subnets + NAT Gateway

- Convert to reusable Terraform modules

- Add CI/CD pipeline for automated deployments
