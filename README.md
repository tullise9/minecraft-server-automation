# Minecraft Server Automation 

## Background

This project automates the deployment and configuration of a Minecraft server on an AWS EC2 instance. We will use configuration management tools to configure the Minecraft server instead of manually configuring it through the AWS Management Console and SSH sessions.

We will use Terraform to provision resources and create an EC2 instance with the correct security group configuration. We will then use Ansible to install Java, download the Minecraft server files, accept the EULA, configure the systemd startup service, and start the Minecraft server.

Lastly, the environment is created by running an automated deployment script.

---

# Requirements

## Software

The following software must be installed on your local machine:

* AWS CLI
* Terraform
* Ansible
* Nmap
* Homebrew (macOS)

---

## AWS Requirements

You will need these values from your active AWS account:

* AWS Access Key ID
* AWS Secret Access Key
* AWS Session Token
* AWS Region
* Output Format 

Run the following command on your local machine to connect to your AWS account:

```bash
aws configure
```

---

## Generate an SSH Key Pair

An AWS EC2 key pair must be created before deployment.

Example:

```bash
aws ec2 create-key-pair \
--key-name minecraft-key-2 \
--query 'KeyMaterial' \
--output text > minecraft-key.pem
```

Update permissions for the key file:

```bash
chmod 400 minecraft-key.pem
```

---

# Deployment Pipeline 

```text
Terraform provisions AWS resources then creates EC2 instance
    ↓
Get the  Public IP of the EC2 instance (stored in output variable file)
    ↓
Ansible Connects Through SSH
    ↓
Install Java
    ↓
Download Minecraft Server
    ↓
Configure systemd Service
    ↓
Start Minecraft Server
    ↓
Verify Connectivity with Nmap
```

---

# Deployment Instructions

## 1) Download the files and navigate to the directory

```bash

cd minecraft-server-automation
```

---

## 2) Deploy the Infrastructure and Configure the Server

Run the deployment script:

```bash
./scripts/deploy.sh
```

---

## 3) Retrieve the Public IP Address

```bash
cd terraform
terraform output public_ip
```

```text
You will need this to verify the Minecraft Server is running
```

---

# Verifying the Minecraft Server

Run the following command from the local machine:

```bash
nmap -sV -Pn -p T:25565 <public-ip>
```

```text
Expected output: 25565/tcp open
```

---

# Connecting to the Minecraft Server

Connect to the Minecraft server by entering the public IP address into the Minecraft multiplayer screen

---

# Resources

## Terraform

* https://www.endpointdev.com/blog/2020/07/automating-minecraft-server/
* https://github.com/dbrennand/mc-hetzner

## Ansible

* https://spacelift.io/blog/ansible-tutorial
* https://docs.ansible.com/projects/ansible/latest/getting_started/index.html

## AWS CLI 

* https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html


