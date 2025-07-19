#!/bin/bash

set -e  # Exit on error

# Install Node.js (only if not already installed)
if ! command -v node &> /dev/null; then
    echo "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "Node.js already installed: $(node --version)"
fi

# Install PM2 globally (only if not already installed)
if ! command -v pm2 &> /dev/null; then
    echo "Installing PM2..."
    sudo npm install -g pm2
else
    echo "PM2 already installed: $(pm2 --version)"
fi
# Navigate to the application directory

APP_DIR="/home/ubuntu/express-backend"  #  path to the app folder in the server

cd $APP_DIR

echo "Pulling latest code from GitHub..."
git pull origin main

echo "Installing dependencies..."
npm install

echo "Restarting app with PM2..."
pm2 restart app || pm2 start app.js --name app

echo "Deployment complete!"
