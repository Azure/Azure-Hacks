# ☁️ Azure Training Sessions

## ℹ️ Introduction

Welcome to the Azure Training Program! Today we'll dive into essential topics related to Microsoft Azure. Our goal is to equip you with practical skills and knowledge that you can apply in real-world scenarios.

### Day 1️⃣: Azure Fundamentals and Landing Zones

- Explore Azure Landing Zones and Hub & Spoke architecture.
- Understand general enterprise architecture in Azure.
- Practical labs: Create vNets, VMs, and storage resources using the Azure GUI (with a clear emphasis that the GUI is read-only).

## 🎬 Getting started

### General prerequisites

- Computer with internet access (admin rights required)
- Microsoft authenticator app pre-installed
- Access to [Azure Portal](https://portal.azure.com/)

Installed fixed versions of the following tools:
- Powershell 7.2.24
- Winget v1.9.25200
- az CLI Version 2.69.0
- VS Code with HashiCorp Terraform extension v2.34.3 installed
- Git version 2.48.1
- Terraform 1.5.7
- Azd 1.12.0
- Dubectl v1.32.2
- Kubctl Client Version: v1.31.4
- Open SSL

### 🧑‍🏫/🧑‍🔬 Program

#### Day 1 — Azure Fundamentals

- [Chapter 0 - Recommended Tools](day1/chapter-0/README.md)
- [Chapter 1 - Theory & Lab: VNet, VMs and Azure Portal](day1/chapter-1/README.md)

Day 1 challenge sequence:

- [Challenge 0 - Deploy the Multi-Region Lab](day1/chapter-1/challenge/README.md)
- [Challenge 1 - Connect with Azure Bastion](day1/chapter-1/challenge1/README.md)
- [Challenge 2 - Build Resiliency with Load Balancer](day1/chapter-1/challenge2/README.md)

## 🗑️ Clean up Azure subscription (Instructors only!)

> [!CAUTION]
> **Disclaimer for the instructors**

Please remember to clean up your Azure subscription after each day. This will help you avoid unnecessary costs and keep your subscription organized.

In order to clean up your Azure subscription, you can use the provided script:

```bash
./clean-up-azure-sub.sh <subscription-id>
```

## 🧑‍🤝‍🧑 Contributors
- Hengameh Bigdeloo - [GitHub](https://github.com/hbigdeloo)
- Demir Senturk - [GitHub](https://github.com/demirsenturk_microsoft)
- Joerg Joess - [GitHub]()
- Sebastian Pfaller - [GitHub]()
- Begum Yivli - [GitHub]()
- Berdiguly Yalymov - [GitHub]()
# ☁️ Azure Training Sessions

## ℹ️ Introduction

Welcome to the Azure Training Program! Over the next six days, we'll dive into essential topics related to Microsoft Azure. Our goal is to equip you with practical skills and knowledge that you can apply in real-world scenarios.

### Day 1️⃣: Azure Fundamentals and Landing Zones

- Explore Azure Landing Zones and Hub & Spoke architecture.
- Understand general enterprise architecture in Azure.
- Practical labs: Create vNets, VMs, and storage resources using the Azure GUI (with a clear emphasis that the GUI is read-only).

### Day 2️⃣: Identity and CI/CD Pipelines

- Dive into Azure Active Directory (Azure AD) and Role-Based Access Control (RBAC).
- Focus on Privileged Identity Management (PIM) following Microsoft standards.
- Components of a CI/CD pipeline: GitHub Actions and Terraform.
- Learn Terraform language basics: resource providers, variables, and modules.
- Hands-on labs for simple deployments via Terraform.

### Day 3️⃣: Hands-On Deployments

- Practical exercises: Create straightforward deployments via Terraform.
- Build components like VMs, vNets, App Gateway, AKS, and a database.
- Ideally, construct a simple application to reinforce concepts.

### Day 4️⃣: Containerization: End-to-End

- Explore best practices for modularizing deployments via CI/CD.
- Build, store, and run containerized applications with Docker, ACR, and AKS.

### Day 5️⃣: Architecting on Azure — Foundations

- Full-day architecture hackathon: Design N-tier applications on Azure.
- Select architecture blueprints, deploy resources, and monitor with Azure Monitor.
- Architecture challenges covering Compute, Storage, and Connectivity pillars.

### Day 6️⃣: Architecting on Azure — Networking & Security

- Continue the architecture hackathon with a focus on networking and security.
- Organize resources in VNets, establish Private Links, and secure resources.
- Apply RBAC, Azure Key Vault, and the Azure Well-Architected Framework.

Get ready for an engaging and informative learning experience! Let’s explore Azure together. 🚀

## 🎬 Getting started

### General prerequisites

- Computer with internet access (admin rights required)
- Microsoft authenticator app pre-installed
- Access to [Azure Portal](https://portal.azure.com/)

Installed fixed versions of the following tools:
- Powershell 7.2.24
- Winget v1.9.25200
- az CLI Version 2.69.0
- VS Code with HashiCorp Terraform extension v2.34.3 installed
- Git version 2.48.1
- Terraform 1.5.7
- Azd 1.12.0
- Dubectl v1.32.2
- Kubctl Client Version: v1.31.4
- Open SSL


### 🧑‍🏫/🧑‍🔬 Program

#### Day 1 — Azure Fundamentals

- [Chapter 0 - Recommended Tools](day1/chapter-0/README.md)
- [Chapter 1 - Theory & Lab: VNet, VMs and Azure Portal](day1/chapter-1/README.md)

Day 1 challenge sequence:

- [Challenge 0 - Deploy the Multi-Region Lab](day1/chapter-1/challenge/README.md)
- [Challenge 1 - Connect with Azure Bastion](day1/chapter-1/challenge1/README.md)
- [Challenge 2 - Build Resiliency with Load Balancer](day1/chapter-1/challenge2/README.md)

#### Day 2 — Security & Infrastructure as Code

- [Chapter 2 - Azure AD: Entra ID](day2/chapter-2/README.md)
- [Chapter 3 - Terraform Basics](day2/chapter-3/README.md)

#### Day 3 — Hands-On Deployments

- [Chapter 4 - Lab: Simple Terraform Deployment](day3/chapter-4/README.md)
- [Chapter 5 - Lab: Developing and Deploying a Complex Landscape](day3/chapter-5/README.md)

#### Day 4 — Containerization: End-to-End

- [Day 4 Overview & Setup](day4/README.md)
- [Chapter 0 - Container Fundamentals](day4/chapter-0/README.md)
- [Chapter 1 - Azure Container Registry](day4/chapter-1/README.md)
- [Chapter 2 - Azure Kubernetes Service](day4/chapter-2/README.md)
- [Chapter 3 - Lab: ACR with Terraform](day4/chapter-3/README.md)
- [Chapter 4 - Lab: AKS with Terraform](day4/chapter-4/README.md)
- [Chapter 5 - Bonus: PostgreSQL with Terraform](day4/chapter-5/README.md)
- [Chapter 6 - Bonus: Azure OpenAI with Terraform](day4/chapter-6/README.md)

#### Day 5 — Architecting on Azure: Foundations

- [Day 5 Overview](day5/README.md)
- [Challenge 0 - Start Architecting](2-ARCHITECTURE/chapter-0/README.md)
- [Challenge 1 - Select a Blueprint](2-ARCHITECTURE/chapter-1/README.md)
- [Challenge 2 - Deploy Resources](2-ARCHITECTURE/chapter-2/README.md)
- [Challenge 3 - Monitor Resources](2-ARCHITECTURE/chapter-3/README.md)

#### Day 6 — Architecting on Azure: Networking & Security

- [Day 6 Overview](day6/README.md)
- [Challenge 4 - Network Architecture: VNet & Private Link](2-ARCHITECTURE/chapter-4/README.md)
- [Challenge 5 - Network Architecture: Secure Resources](2-ARCHITECTURE/chapter-5/README.md)
- [Challenge 6 - Security: RBAC Permissions](2-ARCHITECTURE/chapter-6/README.md)
- [Challenge 7 - Reverse Engineering](2-ARCHITECTURE/chapter-7/README.md)

## 🗑️ Clean up Azure subscription (Instructors only!)

> [!CAUTION]
> **Disclaimer for the instructors**

Please remember to clean up your Azure subscription after each day. This will help you avoid unnecessary costs and keep your subscription organized.

In order to clean up your Azure subscription, you can use the provided script:

```bash
./clean-up-azure-sub.sh <subscription-id>
```

## 🧑‍🤝‍🧑 Contributors
- Hengameh Bigdeloo - [GitHub](https://github.com/hbigdeloo)
- Demir Senturk - [GitHub](https://github.com/demirsenturk_microsoft)
- Joerg Joess - [GitHub]()
- Sebastian Pfaller - [GitHub]()
- Begum Yivli - [GitHub]()
- Berdiguly Yalymov - [GitHub]()