# Hack - Architecting on Azure

Welcome to the "**Architecting on Azure**" hack! 
This challenge series will guide you through the process of architecting a simple N-tier application on Microsoft Azure. You'll gain hands-on experience with key Azure services and best practices in cloud architecture.

## Table of Contents
- [**Architecting on Azure - Hack Introduction**](#hack-introduction)
- **Architect an N-tier App - Hack Challenges**
  - [General Prerequisites & Setup](../1-SETUP/README.md)
  - [Challenge 0 - Start Architecting](chapter-0/README.md)
  - [Challenge 1 - Select a Blueprint to Start](chapter-1/README.md)
  - [Challenge 2 - Deploy the Resources and Web App](chapter-2/README.md)
  - [Challenge 3 - Monitor the Resources](chapter-3/README.md)
    - [Architecture Checkpoint - Drawing](chapter-3/README.md#-architecture-checkpoint---drawing---create-an-architecture-diagram)
  - [Challenge 4a - Network Architecture: Organize the Resources in VNET](chapter-4/README.md)
  - [Challenge 4b - Network Architecture: Private Link](chapter-4/README.md#task-4---establish-a-private-link-between-the-database-and-web-api)
  - [Challenge 5 - Network Architecture: Secure the Resources](chapter-5/README.md)
      - [Architecture Checkpoint - Drawing](chapter-5/README.md#-architecture-checkpoint---drawing---update-the-architecture-diagram)
  - [Challenge 6 - Security - RBAC Permissions](chapter-6/README.md)
  - [Challenge 7 - Architecture: Reverse Engineering](chapter-7/README.md#chapter-7---reverse-engineering)
    - [Architecture Checkpoint - Azure Well-Architected Framework](chapter-7/README.md#azure-well-architected-framework)

## Hack Introduction

This series of challenges is designed to provide a comprehensive, hands-on experience in architecting an N-tier application on Azure. Through these challenges, you will explore the fundamental pillars of cloud architecture—Compute, Storage, and Connectivity—and learn how to monitor and secure your application.

## Architecting an N-tier Application

![System Architecture Overview](image/01_resources.png)

## Pillars of Architecting

Our web application architecture is built upon three foundational pillars: Compute, Storage, and Connectivity. Additionally, we emphasize Monitoring and Security to ensure robustness and reliability.

### Compute
- **[Azure App Services](https://docs.microsoft.com/azure/app-service/)**: Utilized to host both the web frontend and the API backend of the application.
- For guidance on selecting an appropriate Azure compute service, see [Choose an Azure compute service](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-decision-tree).

### Storage
- **[Azure Cosmos DB API for MongoDB](https://docs.microsoft.com/azure/cosmos-db/mongodb/mongodb-introduction)** for database solution.

### Connectivity
- **[Azure Networking Services Overview](https://learn.microsoft.com/en-us/azure/networking/fundamentals/networking-overview)**: Provides a comprehensive overview of networking services.

### Monitoring & Security
- **[Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/)**: Critical for monitoring, logging, and gaining insights into application performance.
- **[Azure Key Vault](https://docs.microsoft.com/azure/key-vault/)**: Used to manage and secure cryptographic keys and secrets.

## General Prerequisites

Before proceeding, please ensure you have completed the necessary setup as described in the [Setup Guide](../1-SETUP/README.md).

**| [< SETUP](../1-SETUP/README.md) | [RELIABILITY >](../3-RELIABILITY/README.md) |**
