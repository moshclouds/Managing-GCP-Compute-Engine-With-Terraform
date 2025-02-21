# 🚀 Managing GCP Compute Engine with Terraform

This repository demonstrates how to manage **Google Cloud Platform (GCP)** Compute Engine instances using **Terraform**. It provides a structured approach for setting up a GCP project, configuring Terraform, and deploying infrastructure resources efficiently.

## 📑 Table of Contents

1. [✅ Prerequisites](#prerequisites)
2. [📂 Project Structure](#project-structure)
3. [⚙️ Setting Up GCP Project](#setting-up-gcp-project)
4. [🔧 Setting Up Terraform](#setting-up-terraform)
5. [🛠️ Terraform Configuration](#terraform-configuration)
6. [🚀 Running Terraform](#running-terraform)
7. [🗑️ Cleaning Up](#cleaning-up)
8. [📌 Additional Resources](#additional-resources)

## ✅ Prerequisites

Before you begin, ensure that you have the following prerequisites:

1. **🖥️ Google Cloud Platform (GCP) Account**: You will need an active Google Cloud account.
2. **📦 Terraform Installed**: Install Terraform on your local machine. If not already installed, follow [this guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) to set up Terraform.
3. **🛠️ gcloud CLI Installed**: The `gcloud` command-line interface is required for authentication. You can install it following [this guide](https://cloud.google.com/sdk/docs/install).
4. **☁️ A Google Cloud Project**: Create a GCP project if you don't have one. You can do so in the [Google Cloud Console](https://console.cloud.google.com/).

## 📂 Project Structure

This repository follows a modular approach to organizing Terraform configurations:

```
.terraform
│── modules
│   ├── compute
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│── .gitignore
│── .terraform.lock.hcl
│── gcp_creds.json
│── main.tf
│── outputs.tf
│── providers.tf
│── README.md
│── terraform.tfstate
│── terraform.tfstate.backup
│── terraform.tfvars
│── variables.tf
```

- **📂 modules/compute/**: Contains modular Terraform configurations for Compute Engine instances.
- **📄 main.tf**: The primary Terraform configuration file.
- **🔧 variables.tf**: Defines reusable Terraform variables.
- **📤 outputs.tf**: Defines the Terraform output values.
- **🛠️ providers.tf**: Configures the provider settings for Terraform.
- **📑 terraform.tfvars**: Stores variable values for Terraform execution.
- **🔐 gcp_creds.json**: The service account key file for GCP authentication (not to be committed).

## ⚙️ Setting Up GCP Project

1. **🌍 Create a Google Cloud Project**:
    - Go to the [Google Cloud Console](https://console.cloud.google.com/).
    - Create a new project or select an existing one.
    - Note your project ID for Terraform configuration.

2. **🔌 Enable Compute Engine API**:
    - Navigate to **APIs & Services > Library**.
    - Search for **Compute Engine API** and click **Enable**.

3. **👤 Create a Service Account**:
    - Navigate to **IAM & Admin > Service Accounts**.
    - Click **Create Service Account**, assign a role (`Compute Admin` or `Project Owner`).
    - Generate a **JSON key** and download it securely.

4. **🌍 Set Environment Variables**:

    ```bash
    export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your-keyfile.json"
    ```

    Replace `/path/to/your-keyfile.json` with the actual path.

## 🔧 Setting Up Terraform

1. **⬇️ Install Terraform**: Follow the [Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli).
2. **🛠️ Initialize Terraform**:

    ```bash
    terraform init
    ```

## 🛠️ Terraform Configuration

Below shows some example ways of configuring , for in detail approach refer the source code of this repo

1. **🔗 Define Provider Configuration** (`providers.tf`):

    ```hcl
    provider "google" {
      project     = var.project_id
      region      = var.region
      credentials = file(var.credentials_file)
    }
    ```

2. **⚙️ Define Compute Engine Resource** (`main.tf`):

    ```hcl
    resource "google_compute_instance" "vm_instance" {
      name         = "terraform-vm"
      machine_type = "e2-micro"
      zone         = "us-central1-a"

      boot_disk {
        initialize_params {
          image = "debian-cloud/debian-11"
        }
      }

      network_interface {
        network = "default"
        access_config {}
      }
    }
    ```

3. **📝 Define Variables (`variables.tf`)**:

    ```hcl
    variable "project_id" {
      description = "GCP Project ID"
      type        = string
    }
    
    variable "region" {
      description = "GCP Region"
      type        = string
      default     = "us-central1"
    }
    
    variable "credentials_file" {
      description = "Path to service account JSON key file"
      type        = string
    }
    ```

4. **📤 Define Outputs (`outputs.tf`)**:

    ```hcl
    output "instance_name" {
      value = google_compute_instance.vm_instance.name
    }
    ```

## 🚀 Running Terraform

1. **📝 Plan the Deployment**:

    ```bash
    terraform plan
    ```

2. **⚡ Apply the Configuration**:

    ```bash
    terraform apply
    ```

    Type `yes` when prompted.

3. **📌 Verify the Deployment**:
    - Navigate to **Compute Engine > VM instances** in the [GCP Console](https://console.cloud.google.com/).

## 🗑️ Cleaning Up

To remove all resources:

```bash
terraform destroy
```

Confirm by typing `yes`.

## 📌 Additional Resources

- 📖 [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- 🏗️ [Google Cloud Terraform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- 🌐 [Google Cloud Console](https://console.cloud.google.com/)

---

This project provides an efficient way to manage **GCP Compute Engine instances** using **Terraform**, following best practices for modular configuration and automation. 🌟

