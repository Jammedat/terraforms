Name of the key pair should be nautilus-kp.

Key pair type must be rsa.

The private key file should be saved under /home/bob/nautilus-kp.pem.
The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task


### First generate a keypair using:
`ssh-keygen -t rsa -f ~/nautilus-kp.pem`