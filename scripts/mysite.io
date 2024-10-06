#!/bin/bash

# Path to the maintenance flag file
FLAG_FILE="/var/www/html/maintenance.flag"

# Nginx site config name
NGINX_CONFIG="mysite.io"

case $1 in
  down)
    echo "Putting mysite.io into maintenance mode..."
    # Create the maintenance flag file
    sudo touch $FLAG_FILE
    # Reload Nginx
    sudo systemctl reload nginx
    echo "mysite.io is now in maintenance mode."
    ;;
    
  up)
    echo "Bringing mysite.io out of maintenance mode..."
    # Remove the maintenance flag file
    sudo rm -f $FLAG_FILE
    # Reload Nginx
    sudo systemctl reload nginx
    echo "mysite.io is now live."
    ;;
    
  *)
    echo "Usage: $0 {down|up}"
    exit 1
    ;;
esac
