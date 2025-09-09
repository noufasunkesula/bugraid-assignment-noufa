# BugRaid.AI – AWS EKS Microservices Deployment with CI/CD Pipeline (Hello World App)

This project provisions AWS infrastructure with **Terraform**, deploys a simple **Hello World app** on **Amazon EKS**, integrates **Redis (ElastiCache)** for caching, and enables **observability** with **CloudWatch** and **OpenSearch**.
CI/CD is automated via **GitHub Actions**.


## Architecture

![Architecture Diagram](a-architecture/architecture-hello-world.png)


## Tech Stack

<p align="center">
  <img src="c-assets/HashiCorp Terraform.png" alt="Terraform" width="60" style="margin: 20px;"/>
  <img src="c-assets/Kubernetes.png" alt="Kubernetes" width="60" style="margin: 20px;"/>
  <img src="c-assets/EKS Cloud.png" alt="EKS" width="60" style="margin: 20px;"/>
  <img src="c-assets/ec2.png" alt="EC2" width="60" style="margin: 20px;"/>
  <img src="c-assets/Simple Storage Service.png" alt="S3" width="60" style="margin: 20px;"/>
  <img src="c-assets/OpenSearch Service.png" alt="OpenSearch" width="60" style="margin: 20px;"/>
  <img src="c-assets/ElastiCache.png" alt="ElastiCache" width="60" style="margin: 20px;"/>
  <img src="c-assets/CloudWatch.png" alt="CloudWatch" width="60" style="margin: 20px;"/>
  <img src="c-assets/Elastic Load Balancing.png" alt="ELB" width="60" style="margin: 20px;"/>
  <img src="c-assets/GitHub Actions.png" alt="GitHub Actions" width="60" style="margin: 20px;"/>
</p>

## Project Phases

| Phase | Description | Tools/Services Used | Outcome |
|-------|-------------|---------------------|---------|
| **1. IAM & Credentials** | Created `bugraid-noufa-admin` IAM user with required permissions | AWS IAM | Secure AWS access for Terraform & kubectl |
| **2. Terraform Init** | Wrote provider, backend config, and state management | Terraform + S3 + DynamoDB | Remote state management enabled |
| **3. VPC Setup** | Provisioned VPC, subnets, and networking | Terraform AWS VPC Module | Network foundation for EKS |
| **4. EKS Cluster** | Deployed EKS cluster and managed node groups | Terraform EKS Module | Running Kubernetes cluster |
| **5. S3 Bucket** | Created versioned and encrypted bucket for logs/configs | Terraform AWS S3 | Secure log storage |
| **6. OpenSearch** | Provisioned OpenSearch domain with FGAC + HTTPS | Terraform AWS OpenSearch | Log analytics platform ready |
| **7. Redis** | Provisioned ElastiCache Redis cluster | Terraform AWS ElastiCache | Caching backend available |
| **8. CloudWatch** | Enabled control plane logging and created alarm | Terraform AWS CloudWatch | Monitoring and alerting |
| **9. App Deployment** | Deployed Hello World app, service, and Fluent Bit config | Kubernetes manifests (kubectl) | App running with LoadBalancer & logging |
| **10. Verification** | Tested pods, services, and external ELB endpoint | kubectl, Browser | Verified app running successfully |
| **11. CI/CD** | Designed and executed GitHub Actions workflow | GitHub Actions | Automated Terraform + kubectl deploy |
| **12. Documentation** | Prepared README with architecture, screenshots, and challenges | Markdown + Images | Complete project repo for submission |


## Setup Instructions

```bash
git clone https://github.com/noufasunkesula/bugraid-assignment.git
cd bugraid-assignment

aws configure
# Use Access Key & Secret of IAM user: bugraid-noufa-admin

#terraform workflow
terraform init
terraform plan
terraform apply -auto-approve

#congig kubectl for eks
aws eks update-kubeconfig --region ap-south-1 --name bugraid-noufa-eks
kubectl get nodes

# deploy app
kubectl apply -f kubernetes-manifests/
kubectl get pods
kubectl get svc hello-world-service
```

## Screenshots
### Infrastructure

<p align="center">
  <img src="b-bugraid-screenshots/01-infra-terraform-apply.jpg" alt="Terraform Apply" width="400" style="margin: 15px;"/>

</p>


### Kubernetes Pods & Service

<p align="center">
  <img src="b-bugraid-screenshots/09-pods-running.jpg" alt="Pods Running" width="400" style="margin: 15px;"/>

</p>

### Hello World Application

<p align="center">
  <img src="b-bugraid-screenshots/10-hello-world-app.jpg" alt="Hello World App" width="500" style="margin: 20px;"/>
</p>

### CI/CD Pipelien Success

<p align="center">
  <img src="ci-cd-pipeline-success.jpg" alt="ci-cd-pipeline-success" width="500" style="margin: 20px;"/>
</p>

 You can refer to all the screenshots here: [Screenshots Folder](b-bugraid-screenshots/)

## Challenges Faced

- **OpenSearch Access Issues**
    - Initially got `anonymous user not authorized` error.
    - Solved by enabling fine-grained access control (FGAC), creating an admin user, and restricting access policy to my AWS account.
- **Terraform Module Mismatches**
    - Early versions of `terraform-aws-eks` module didn’t support `managed_node_groups`.
    - Fixed by upgrading to a newer module version and replacing old arguments with `eks_managed_node_groups`.
- **CloudWatch Logging Problems**
    - Tried using `aws_eks_cluster_logging` (deprecated resource) and got errors.
    - Fixed by using `cluster_enabled_log_types` inside the EKS module.
- **Resource Dependency Errors**
    - Terraform sometimes failed because resources weren’t created in order (VPC before EKS, etc.).
    - Solved by referencing outputs between modules (`vpc_id`, `private_subnets`).
- **Redis Confusion**
    - Initially thought Redis had to be deployed as a pod in EKS.
    - Clarified that requirement was ElastiCache Redis → integrated via Terraform, removed unused manifests.
- **Pipeline Failures in GitHub Actions**
    - First run failed due to missing AWS credentials in GitHub secrets.
    - Fixed by adding `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` under repo → Settings → Secrets.
 
## Built By

Noufa Sunkesula

Mail ID: noufasunkesula@gmail.com

Contact: +91  8106859686
