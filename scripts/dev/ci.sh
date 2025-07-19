#!/bin/bash

set -e  # Exit on error

SERVER_IP="13.234.11.52"  # replace with your actual server IP

# Secure the key file (used locally or in runner)
chmod 400 infrastructure/ec2instance-key

# SSH into the server and run the deploy script remotely
ssh -i infrastructure/ec2instance-key -o StrictHostKeyChecking=no ubuntu@$SERVER_IP 'bash -s' < scripts/dev/deploy.sh
