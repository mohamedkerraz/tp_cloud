#!/bin/bash

# Source environment variables from .env file
source .env

# Initialize Terraform
terraform init

# Apply Terraform configuration with auto-approval
terraform apply -auto-approve

# Wait for 30 seconds before launching the Ansible playbook
echo "Waiting for 30 seconds before launching the Ansible playbook..."
sleep 30

# Execute the Ansible playbook to configure Docker Swarm
ansible-playbook -i inventory.yml swarm.playbook.yml
