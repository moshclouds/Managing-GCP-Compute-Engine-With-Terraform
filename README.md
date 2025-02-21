# 🚀 Managing GCP Compute Engine with Terraform

<p align="center">
  <img width="720" alt="Image" src="https://github.com/user-attachments/assets/4319de6e-4c41-4896-b9cb-85525d684fac" />
</p>

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

![Image](https://github.com/user-attachments/assets/c56df151-9866-42d3-81cb-6af6d23c988d)

![Image](https://github.com/user-attachments/assets/5beed902-ff56-41d4-8177-3157ce52c3ee)

2. **🔌 Enable Compute Engine API**:
    - Navigate to **APIs & Services > Library**.
    - Search for **Compute Engine API** and click **Enable**.

![Image](https://github.com/user-attachments/assets/01c3ec6d-35fc-49a3-90a1-873748727ead)

![Image](https://github.com/user-attachments/assets/7eadcc45-c228-47e4-bfc3-6c0409bbc5ae)

![Image](https://github.com/user-attachments/assets/6a188854-3ba0-4de1-abe6-d7183ea79048)

![Image](https://github.com/user-attachments/assets/bfb3cedb-1961-4bd8-8cd4-d665a64506f8)

![Image](https://github.com/user-attachments/assets/66983cb1-09ee-4278-926c-1c89d6349d78)

3. **👤 Create a Service Account**:
    - Navigate to **IAM & Admin > Service Accounts**.
    - Click **Create Service Account**, assign a role (`Compute Admin` or `Project Owner`).
    - Generate a **JSON key** and download it securely.


![Image](https://github.com/user-attachments/assets/8c03dd26-e9dd-4cc4-9a09-3dd76f54c1df)

![Image](https://github.com/user-attachments/assets/53c39515-fcbf-4016-8276-3c78529273dd)

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
    ![Image](https://github.com/user-attachments/assets/3cefb889-0633-4166-8b50-e72a888388a5)

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

    ![Image](https://github.com/user-attachments/assets/ba289ca6-5e08-4215-8c12-1107d04783f6)

3. **📌 Verify the Deployment**:
    - Navigate to **Compute Engine > VM instances** in the [GCP Console](https://console.cloud.google.com/).

## 🗑️ Cleaning Up

To remove all resources:

```bash
terraform destroy
```

Confirm by typing `yes`.

![Image](https://github.com/user-attachments/assets/3537e7f8-37e5-4dbc-a60a-96508cfaa037)

![Image](https://github.com/user-attachments/assets/f9d61633-a758-4049-af14-17eca8d8153f)


## 📌 Additional Resources

- 📖 [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- 🏗️ [Google Cloud Terraform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- 🌐 [Google Cloud Console](https://console.cloud.google.com/)

---

This project provides an efficient way to manage **GCP Compute Engine instances** using **Terraform**, following best practices for modular configuration and automation. 🌟

