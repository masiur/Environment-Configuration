
### Step 1: Config nginx

    sudo nano /etc/nginx/sites-available/mysite.io

```nginx
server {
    listen 80;
    server_name mysite.io;

    location / {
        if (-f /var/www/html/maintenance.flag) {
            return 503;
        }
        # Your other config like proxy_pass goes here.
    }

    error_page 503 @maintenance;
    
    location @maintenance {
        root /var/www/html;
        try_files /maintenance.html =503;
    }
}
```


### Step 2: Create a Bash Script
Create a new bash script in the /usr/local/bin/ directory (or any directory in your system path) to manage the maintenance mode:

```bash
sudo nano /usr/local/bin/mysite.io
```

### Step 3: Add the Script Logic
Add the following code to the script file to handle both the `down` and `up` commands:
[mysite.io](./scripts/mysite.io)

### Step 4: Make the Script Executable

Give the script execution permissions:

```bash
sudo chmod +x /usr/local/bin/mysite.io` 
```

### Step 5: Using the Script

Now you can easily toggle the maintenance mode by using the following commands:

-   To put `mysite.io` in maintenance mode:
 
 ```bash   
 my_site.io down
``` 
-   To bring `mysite.io` back online:
    
    ```bash
    mysite.io up
    ```
### Step 5: Done ✅