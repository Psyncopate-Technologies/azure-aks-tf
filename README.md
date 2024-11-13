# Overview
This document helps you to setup AKS service on an existing Azure Resource Group with Ingress Controller(AGIC)

# Pre-requisites
1. Access to Azure Portal and Subsription
2. Kubectl installed
3. Terraform installed
4. Azure CLI installed
5. Register an App, Service Principal using which the terraform will be executed.
6. Be prepared with the following details
    * Tenant ID
    * Subscription ID
    * Region where the Cluster is to be created
    * Resource Group Name
    * Resource Group Location
    * Service Principle ID (Application (client) ID)
    * Service Principal Secret
    * Service Principal Object ID (The 'id' attribute from the result of 'az ad sp list --filter "displayName eq '<Service_Principal_name>'"')

# AKS Cluster Setup

## Populate TF Variables
1. Clone the repository
```bash
git clone <repository-url>
cd <repository-directory>
```

2. Replace the TF variables 
```bash
vi <repository-directory>/terraform.auto.tfvars
```
Replace the variable values here suitable for your environment.

## Initialize the TF Providers
From your terminal, run the following
```bash
cd <repository-directory>
terraform init -upgrade
```

## Plan for TF Execution
From your terminal, run the following
```bash
cd <repository-directory>
terraform plan -out main.tfplan
```
Validate the plan for the resources that you require.

## Apply TF Resources
From your terminal, run the following
```bash
cd <repository-directory>
terraform apply main.tfplan
```
Wait for the execution to complete successfully.

## Validate AKS Resources
Navigate to Azure portal and verify if the AKS Cluster, Nodepools and Ingress Gateway is enabled for your cluster.


# kubectl Configuration
Once terraform successfully completes provisioning all required resources, you can setup your local kubectl context to the newly provisioned cluster.
1. Retrieve the Kubeconfig to your local directory
```bash
cd <repository-directory>
echo "$(terraform output kube_config)" > ./azurek8s
```

2. Remove unwanted characters from the retrieved kubeconfig file
```bash
cd <repository-directory>
vi ./azurek8s
```
Delete EOT from the first and last line of the file if present

3. Set environment variable
```bash
cd <repository-directory>
export KUBECONFIG=./azurek8s
```

4. Run kubectl commands
```bash
cd <repository-directory>
kubectl get nodes
kubectl get pods
```

5. Verify the ingress controller pod is running
```bash
cd <repository-directory>
kubectl get pods -n kube-system
```
You should find a pod running by the name 'ingress-appgw-deployment-xxxxx'.


# Application Deployment
## Molina - Healthcare Usecase
[Molina - Healthcare Usecase](molina_healthcare_usecase.md)

# AKS Cluster Shutdown
Once all your activities are completed, brind downt he AKS cluster.

```bash
cd <repository-directory>
terraform destroy
```