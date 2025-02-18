#!/bin/bash

# Update the package list and install Apache
apt update
apt install -y apache2

# Get the instance metadata using Azure Instance Metadata Service (IMDS)
INSTANCE_ID=$(curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance/compute/vmId?api-version=2021-02-01&format=text")

# Install the Azure CLI (optional, if you need to interact with Azure resources)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Download images from Azure Blob Storage (if needed)
# az storage blob download --account-name <storage_account_name> --container-name <container_name> --name project.webp --file /var/www/html/project.png --auth-mode login

# Create a simple HTML file with the portfolio content and display the images
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    /* Add animation and styling for the text */
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 1</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to the House</p>
  
</body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2