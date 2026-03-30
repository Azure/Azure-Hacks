# Day 4 - Containerization: End-to-End

## Goal 🎯

This module provides a complete, self-contained guide to containerization and cloud services on Azure. You will learn what containers are, use Docker, Azure Container Registry (ACR), and Azure Kubernetes Service (AKS) to build, store, and run containerized applications — then extend your infrastructure with a managed database and AI services.

By the end of this module you will have:
- Understood what containers are and how they differ from VMs
- Installed and verified all required tools (Docker, kubectl, az CLI)
- Built a container image locally and in the cloud
- Pushed images to Azure Container Registry
- Deployed a Kubernetes cluster on AKS
- Deployed a containerized application to AKS
- Created an ACR and AKS cluster using Terraform
- Deployed a PostgreSQL database with private networking (bonus)
- Deployed an Azure OpenAI endpoint and called GPT-4o-mini (bonus)

## Prerequisites

- An Azure subscription (the same one you have been using since Day 1)
- Tools installed during [Day 1 - Chapter 0](../day1/chapter-0/README.md): Azure CLI, Terraform
- Completion of setup verification steps below

## Module Structure

### 0 - Setup
Install and verify all tools needed for this module.

[Setup instructions](./setup.md)

### 1 - Container Fundamentals
What are containers? How do they work? How are they different from VMs? Hands-on with Docker.

[Chapter 0: Container Fundamentals](./chapter-0/README.md)

### 2 - Azure Container Registry (ACR)
Create an ACR, build images in the cloud, and manage your container image store.

[Chapter 1: Azure Container Registry](./chapter-1/README.md)

### 3 - Azure Kubernetes Service (AKS)
Deploy a Kubernetes cluster, connect to it, and deploy your containerized application.

[Chapter 2: Azure Kubernetes Service](./chapter-2/README.md)

### 4 - Lab: ACR with Terraform
Hands-on lab — create an ACR using Terraform.

[Chapter 3: Lab - ACR with Terraform](./chapter-3/README.md)

### 5 - Lab: AKS with Terraform
Hands-on lab — deploy a full AKS cluster and connect it to ACR using Terraform.

[Chapter 4: Lab - AKS with Terraform](./chapter-4/README.md)

### 6 - Bonus Lab: PostgreSQL with Terraform
Deploy an Azure Database for PostgreSQL Flexible Server with private DNS and VNet injection.

[Chapter 5: Lab - PostgreSQL with Terraform](./chapter-5/README.md)

### 7 - Bonus Lab: Azure OpenAI with Terraform
Deploy an Azure OpenAI service with GPT-4o-mini and test it with Entra ID authentication.

[Chapter 6: Lab - Azure OpenAI with Terraform](./chapter-6/README.md)

## Continue

**[< back to Day 3](../day3/chapter-5/README.md) | [home](../README.md)**
