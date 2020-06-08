
 ### www & non-www redirect with https
![enter image description here](https://github.com/masiur/Environment-Configuration/blob/master/files/redirection.jpg)
 #### Confguratin file for accepting http request and redirect
    # /etc/apache2/sites-available/sustcse12.xyz.conf
    # Accept non-www or www http request
    <VirtualHost *:80>
        ServerName www.sustcse12.xyz
        ServerAlias sustcse12.xyz
        RedirectMatch permanent ^/(.*) https://www.sustcse12.xyz/$1
    </VirtualHost>  
  
 #### Confguratin file for accepting https request and redirect and serve
  
    # /etc/apache2/sites-available/sustcse12.xyz-le-ssl.conf
   
    # Accept non-www https request
    <IfModule mod_ssl.c>
     <VirtualHost *:443>
       ServerName sustcse12.xyz
       RedirectMatch permanent ^/(.*) https://www.sustcse12.xyz/$1
     </VirtualHost>
    </IfModule>
    
    # Accept https request with www
    # Serving Configuration
    <IfModule mod_ssl.c>
     <VirtualHost *:443>
      ServerAdmin yourmail@example.com
      ServerName www.sustcse12.xyz
      DocumentRoot /var/www/html/sustcse12.xyz/SUST-CSE-12/public
      <Directory "/var/www/html/sustcse12.xyz/SUST-CSE-12/public/">
      AllowOverride All
      </Directory>
    
      Include /etc/letsencrypt/options-ssl-apache.conf
      SSLCertificateFile /etc/letsencrypt/live/sustcse12.xyz/fullchain.pem
      SSLCertificateKeyFile /etc/letsencrypt/live/sustcse12.xyz/privkey.pem
     </VirtualHost>
    </IfModule>
    

