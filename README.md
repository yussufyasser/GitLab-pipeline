# GitLab CI/CD Pipeline for EKS Deployment

This project automates the provisioning of an Amazon EKS (Elastic Kubernetes Service) cluster and the deployment of a static web application using GitLab CI/CD. The pipeline leverages Terraform for infrastructure as code (IaC) and Kubernetes manifests for application deployment.

![App](result.png)
---

## 📁 Project Structure

```
.
├── .gitlab-ci.yml             # GitLab CI/CD pipeline configuration
├── Dockerfile                 # Custom Docker image for CI runner environment
├── terraform/                 # Terraform scripts to create EKS cluster
│   ├── main.tf
│   ├── provider.tf
│   ├── backend.tf
│   └── variables.tf
└── kubernetes/                # Kubernetes manifests for application
    ├── webpage-deployment.yaml
    └── webpage-service.yaml
```

---

## 🚀 CI/CD Pipeline Overview

The pipeline defined in `.gitlab-ci.yml` has two stages:

1. **Provisioning**:
   - Initializes Terraform.
   - Provisions the EKS cluster using `terraform apply`.

2. **Deploying**:
   - Configures kubectl using AWS CLI.
   - Applies Kubernetes manifests to deploy the static website.

---

## 🐳 Docker Image

The custom Docker image used in the GitLab Runner is based on Amazon Linux 2 and includes:

- `terraform`
- `aws-cli v2`
- `kubectl`

These tools are installed in the `Dockerfile` and ensure the runner has all necessary dependencies for infrastructure and deployment automation.

---

## 🛠️ Requirements

- GitLab Runner using the custom Docker image built from the included Dockerfile.
- AWS credentials configured as CI/CD environment variables:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
- Remote backend for Terraform state (configured in `backend.tf`).

---

## ☁️ Terraform Setup

Key settings in `main.tf`:
- Creates IAM roles and security groups.
- Provisions an EKS cluster using the `aws_eks_cluster` resource.
- Generates necessary node groups and networking components.

Run manually or through CI:

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

---

## ☸️ Kubernetes Deployment

Manifests in the `kubernetes/` directory include:

- `webpage-deployment.yaml`: Deploys the static web app container.
- `webpage-service.yaml`: Exposes the app using a LoadBalancer service.

After provisioning, the pipeline automatically applies them:

```bash
kubectl apply -f kubernetes/
```

---

## ✅ Pipeline Execution

Once changes are pushed to the repository, GitLab will:

1. Use the Dockerfile to spin up the correct environment.
2. Run Terraform to create or update the EKS infrastructure.
3. Deploy the static web app to the created cluster.

---

## 📷 Output Verification

After deployment, verify with:

```bash
kubectl get all
```

To retrieve the LoadBalancer external IP:

```bash
kubectl get svc
```

Open the IP in your browser to view the deployed static site.

---

## 📌 Notes

- Make sure your IAM user has EKS, EC2, and VPC permissions.
- Clean up unused infrastructure with `terraform destroy`.
