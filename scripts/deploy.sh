#!/bin/bash

cd terraform
terraform apply -auto-approve

PUBLIC_IP=$(terraform output -raw public_ip)

cd ../ansible

cat > inventory.ini <<EOF
[minecraft]
$PUBLIC_IP ansible_user=ubuntu ansible_ssh_private_key_file=../minecraft-key.pem
EOF

until ssh -o StrictHostKeyChecking=no -i ../minecraft-key.pem ubuntu@$PUBLIC_IP "exit" 2>/dev/null
do
  echo "Waiting for SSH..."
  sleep 10
done

ansible-playbook -i inventory.ini playbook.yml