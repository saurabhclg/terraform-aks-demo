# Terraform AKS Demo

Terraform configuration for provisioning Azure Kubernetes Service (AKS) clusters with separate dev and prod environments and a shared AKS module.

## Repository Layout
- `versions.tf` / `provider.tf`: global Terraform and provider constraints.
- `modules/aks`: reusable AKS module (cluster + Log Analytics workspace).
- `environments/dev` and `environments/prod`: environment-specific stacks and remote backend settings.

## Prerequisites
- Terraform `>= 1.5.0`.
- Azure CLI authenticated to the target subscription: `az login && az account set --subscription <id>`.
- Remote state storage (adjust names as needed):
  - Resource group: `devops-demo`
  - Storage account: `devopsdemoabb`
  - Container: `tfstate`
  - Keys: `dev/aks.tfstate` and `prod/aks.tfstate`

To create the backend if it does not exist:
```sh
az group create -n devops-demo -l "Central India"
az storage account create -g devops-demo -n devopsdemoabb -l "Central India" --sku Standard_LRS
az storage container create --account-name devopsdemoabb -n tfstate
```

## Usage
From the repo root:
```sh
cd environments/<dev|prod>
terraform init       # configures azurerm backend declared in backend.tf
terraform plan
terraform apply
```

## What Gets Created
- AKS cluster with a system node pool sized via `node_count` and `vm_size`.
- System-assigned managed identity.
- Azure CNI networking (`network_plugin = "azure"`).
- Log Analytics workspace for the cluster’s OMS agent.
- Key Vault Secrets Provider enabled (secret rotation disabled by default).

## Module Inputs (set in each environment)
- `cluster_name`: AKS name and log analytics prefix.
- `location`: Azure region.
- `resource_group_name`: resource group where AKS and Log Analytics reside.
- `dns_prefix`: DNS prefix for the cluster.
- `node_count`: default `1` (dev) / `3` (prod in sample configs).
- `vm_size`: default `Standard_B2s_v2`.

## Outputs
- `cluster_name`
- `kube_config` (raw kubeconfig content; marked sensitive)

## Cleanup
From the chosen environment directory:
```sh
terraform destroy
```
