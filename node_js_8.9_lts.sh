#!/bin/bash
echo "Installing CURL"
sudo apt-get install -y curl
sudo apt-get install -y python-software-properties
echo "Setting up Node.js 8.* LTS"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
echo "Thank you"
