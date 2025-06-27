# ☁️ OCI Terraform Infrastructure

This repository contains **modular Terraform configurations** to provision Oracle Cloud Infrastructure (OCI) resources in a flexible, reusable way. It leverages Terraform modules to manage core networking components, compute instances, storage, and security resources efficiently.

---

## 📦 Features

- Modular design for easy customization and reuse  
- Creates Virtual Cloud Network (VCN) and related networking components:  
  - Internet Gateway  
  - NAT Gateway  
  - Public and Private Subnets  
  - Route Tables and Security Lists  
- Launches compute instances including:  
  - Bastion host for secure SSH access  
  - Private compute instances  
- Creates Object Storage buckets  
- Outputs key resource IDs and IPs for integration and verification  

---

## 📁 Project Structure

```

oci-terraform-infra/
│
├── main.tf                # Root configuration that calls modules and sets inputs
├── variables.tf           # Root variables definition
├── outputs.tf             # Root outputs aggregation
├── terraform.tfvars       # User-specific variable values (excluded from VCS)
├── provider.tf            # Provider setup (OCI)
├── README.md              # This documentation
│
├── modules/               # Reusable modules for individual OCI resources
│   ├── bastion\_instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── internet\_gateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── nat\_gateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── object\_storage/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── private\_instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── private\_subnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── public\_subnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security\_list/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── vcn/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf

````

---

## 🚀 Getting Started

### Prerequisites

- Terraform v1.0+  
- OCI account with API key and necessary IAM permissions  
- SSH key pair for instance access  

---

### 1. Clone the Repository

```bash
git clone https://github.com/vigneshkattamudi/oci-terraform-infra.git
cd oci-terraform-infra
````

---

### 2. Configure Variables

Create a `terraform.tfvars` file in the root directory with your OCI environment details:

```hcl
tenancy_ocid        = "ocid1.tenancy.oc1..example"
user_ocid           = "ocid1.user.oc1..example"
fingerprint         = "12:34:56:78:90:ab:cd:ef:gh:ij"
private_key_path    = "~/.oci/oci_api_key.pem"
compartment_ocid    = "ocid1.compartment.oc1..example"
availability_domain = "UK-LONDON-1-AD-1"
ssh_public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ..."
cidr_block          = "10.0.0.0/16"
display_name        = "my-vcn"
```

*Modify or add variables depending on your requirements.*

---

### 3. Initialize Terraform

```bash
terraform init
```

---

### 4. Plan & Apply

To see what Terraform will do:

```bash
terraform plan
```

To create resources:

```bash
terraform apply
```

---

## 📦 Using Modules

Each module manages a specific resource or group of resources. The root `main.tf` calls these modules with inputs defined via variables. You can customize or reuse modules in other projects by copying the relevant folder under `modules/`.

Example of module usage in `main.tf`:

```hcl
module "vcn" {
  source          = "./modules/vcn"
  cidr_block      = var.cidr_block
  compartment_id  = var.compartment_ocid
  display_name    = var.display_name
}

module "internet_gateway" {
  source         = "./modules/internet_gateway"
  vcn_id         = module.vcn.vcn_id
  compartment_id = var.compartment_ocid
  display_name   = "my-internet-gateway"
}
```

---

## 🔐 SSH Access

After the compute instances and bastion host are created, connect using:

```bash
ssh -i <path_to_private_key> opc@<public_ip>
```

---

## 📤 Outputs

Terraform will output useful details such as:

* Public and Private IP addresses
* Instance OCIDs
* Subnet OCIDs

---

## 🧹 Cleanup

To delete all created resources:

```bash
terraform destroy
```