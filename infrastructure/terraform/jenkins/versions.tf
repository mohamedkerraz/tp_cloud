terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.54.1"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }
  }

  # Optionnel : spécifier la version de Terraform pour assurer la compatibilité
  required_version = ">= 1.1.0"
}

provider "aws" {
  # Configuration de l'authentification et de la région
  region = var.aws_region
}

provider "ansible" {
  # Configuration pour Ansible
}
