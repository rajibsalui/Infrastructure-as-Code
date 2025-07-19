#!/bin/bash

set -e  # Exit on error

APP_DIR="/home/ubuntu/express-backend"  #  path to the app folder in the server

cd $APP_DIR

echo "Pulling latest code from GitHub..."
git pull origin main

echo "Installing dependencies..."
npm install

echo "Restarting app with PM2..."
pm2 restart app || pm2 start app.js --name app

echo "Deployment complete!"
