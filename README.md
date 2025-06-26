# ☁️ OCI Terraform Infrastructure

This repository contains Terraform configuration files to automate the provisioning of infrastructure on **Oracle Cloud Infrastructure (OCI)**. It supports setting up core networking resources and launching compute instances using your chosen image and configuration.

---

## 📦 Features

- ✅ Creates a Virtual Cloud Network (VCN)
- ✅ Configures Internet Gateway and Route Tables
- ✅ Creates public subnet(s)
- ✅ Launches a Compute instance (Oracle Linux or Ubuntu)
- ✅ Attaches SSH key for secure access
- ✅ Exposes outputs for public/private IPs and instance OCID

---

## 📁 Project Structure

```

oci-terraform-infra/
├── main.tf                 # Root module, includes all other configs
├── compute\_instance.tf     # Compute instance definition
├── provider.tf             # OCI provider block
├── variables.tf            # Input variables
├── output.tf               # Outputs to display after apply
├── vcn.tf                  # Networking components (VCN, subnet, gateway)
└── terraform.tfvars        # (Optional) Your custom variable values

````

---

## 🚀 Getting Started

### Prerequisites

- Terraform v1.0+
- OCI Account with:
  - API key configured
  - Required IAM policies
- SSH key pair (for instance login)

---

### 🧰 1. Clone the Repository

```bash
git clone https://github.com/vigneshkattamudi/oci-terraform-infra.git
cd oci-terraform-infra
````

---

### ⚙️ 2. Set Variables

Create a `terraform.tfvars` file in the root directory:

```hcl
tenancy_ocid        = "ocid1.tenancy.oc1..example"
user_ocid           = "ocid1.user.oc1..example"
fingerprint         = "12:34:56:78:90:ab:cd:ef:gh:ij"
private_key_path    = "~/.oci/oci_api_key.pem"
compartment_ocid    = "ocid1.compartment.oc1..example"
availability_domain = "UK-LONDON-1-AD-1"
ssh_public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ..."
```

---

### 🔧 3. Initialize Terraform

```bash
terraform init
```

---

### 🚀 4. Apply the Configuration

```bash
terraform apply
```

---

### 🔐 SSH Access

Once deployed, connect to your compute instance:

```bash
ssh -i sshoci_key.pem opc@<public_ip>
```

Ensure your SSH private key has the correct permissions:

```bash
chmod 600 sshoci_key.pem
```

---

## 📤 Outputs

After applying, Terraform will output:

* ✅ Public IP
* ✅ Private IP
* ✅ Instance OCID
* ✅ Subnet OCID

---

## 🧹 Destroy Resources

```bash
terraform destroy
```

---