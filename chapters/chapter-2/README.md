# Chapter 2 - Networking & IaC

## Goal

The goal of this chapter is to continue with Part 2 of Networking and introduce you to the basics of Terraform.

In this chapter we will cover the following topics:

### Networking

- Azure Public IP Address
- Azure Bastion

### IaC & Terraform

- IaC Overview
- Terraform Intro
- Providers & Multi-Providers
- Variables, Locals, Outputs
- Expressions & Functions
- State Management, Terraform Import & Workspace

## Theory

> [!CAUTION]
> For all the following topics there are slides available for the instructor (and these will be shared with the participants): <https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=YQYUAp>

### Public IP Address

A public IP address is a globally unique IP address that is reachable from the internet. You can associate a public IP address with a VM to enable communication with the internet. Azure provides dynamic and static public IP addresses.

### Bastion

Azure Bastion is a fully managed PaaS service that provides secure and seamless RDP and SSH access to your VMs directly through the Azure Portal. Azure Bastion is provisioned directly in your VNet and supports all VMs in your VNet using SSL without any exposure through public IP addresses.

## IaC Overview

Objective: Understand the basic concept of IaC and its benefits.

> [!IMPORTANT]
> Please use the chapter **"IaC Overview"** from the slides: <https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=YQYUAp>

### Task

Discuss the benefits of IaC with the participants and show a comparison between traditional infrastructure setup and IaC.

### Terraform Intro

> [!IMPORTANT]
> Please use the chapter **"Terraform Intro"** from the slides: <https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=YQYUAp>

Set up Terraform and understand its basic structure.

### Terraform Providers

> [!IMPORTANT]
> Please use the chapter **"Terraform Providers"** from the slides: <https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=YQYUAp>

### Terraform Variables, Locals and Outputs

> [!IMPORTANT]
> Please use the chapter **"Terraform Variables, Locals and Outputs"** from the slides: <https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=YQYUAp>

### Terraform Expressions & Functions

> [!IMPORTANT]
> Please use the chapter **"Terraform Expressions & Functions"** from the slides: <https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=YQYUAp>

### Terraform State Management, Terraform Import & Workspace

> [!IMPORTANT]
> Please use the chapter **"Terraform State Management, Terraform Import & Workspace"** from the slides: <https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=YQYUAp>

## Labs

### Public IP Address

Please follow the instructions in this lab: <https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses>

### Bastion

Please follow the instructions in this lab: <https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/configure-public-ip-bastion>

### Terraform Intro

You can use [01_intro](../../solutions/chapter-2/01_intro) as a starting point for a very simple example and validation if your terraform and azure cli setup is working.

### Terraform Providers

You can use [02_providers](../../solutions/chapter-2/02_providers) as a starting point for a very simple example to showcase multiple providers with aliases

### Terraform Variables, Locals and Outputs

You can use [03_variables](../../solutions/chapter-2/03_variables) as a starting point for a minimalistic example to showcase variables, locals and outputs.

### Terraform Expressions & Functions

You can use [04_expressions](../../solutions/chapter-2/04_expressions) as a starting point for a minimalistic example to showcase expressions and functions.

### Terraform State Management, Terraform Import & Workspace

You can use [05_state](../../solutions/chapter-2/05_state) as a starting point for a minimalistic example to showcase state management, terraform import and workspace.

## Continue

**[< back](../chapter-4/README.md) | [home](../../README.md) | [next >](../chapter-6/README.md) | [solutions](../../solutions/chapter-5/README.md)**
