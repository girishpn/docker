
---

  - hosts: local
    connections: local
    become: yes
    become_method: sudo
     
    - name: permission to "devopsdocker" docker bind directory
      file:
          path=/var/www/devopsdocker
          state=directory
          owner=apache
          group=apache
          mode=7777
    - name: Give permission to the documentroot
      file:
          path=/var/www
          state=directory
          owner=root
          group=root
          mode=7777
    - name: create nginx index page
      file:
          path=/var/www/devopsdocker/index.html
          state=touch
          owner=nginx
          group=nginx
          mode=7777
    - name: edit index.html file
      blockinfile:
          path:/var/www/devopsdocker/index.html
          block: |
              <html>
              <head>
              <title>dvops-test-Nginx</title>
              </head>
              <body>
              <h1>CFR DevOps test-Nginx</h1>
              </body>
              </html>
    - name: create index.php page
      file:
          path=/var/www/devopsdocker/index.php
          state=touch
          owner=apache
          group=apache
          mode=7777	  
    - name: edit index.php 
      blockinfile:
          path:/var/www/devopsdocker/index.php
          block: |
              <?php
              phpinfo();
              ?>
    - name: create nginx conf file
      file:
          path=/etc/nginx/conf.d/virtual.conf
          state=touch
          owner=nginx
          group=nginx
          mode=7777  
    - name: Edit nginx conf.
      blockinfile:
      path: /etc/nginx/conf.d/virtual.conf
      block: |
              server {
              listen 80;
              root /var/www/devopsdocker; 
              index index.html index.htm;
              server_name devopsdocker;
              
              location \ {
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $remote_addr;
              proxy_set_header Host $host;
              proxy_pass http://127.0.0.1:8080;
              }
              
              location \ {
              if ($request_filename = [gif|jpg|png])
              {return http://www.devopsdocker.com/index.html;
               }

              location ~ /\.ht {
              deny all;
              }
              }
    - name: Change apache listen port 
      lineinfile:
          path: /etc/httpd/conf/httpd.conf
          regexp: 'Listen 80'
          line: 'Listen 127.0.0.0.1:8080'		  
    - name: create virtual host in apache
      blockinfile:
          path: /etc/httpd/conf/httpd.conf
          block: |
            <VirtualHost *:8080>
            ServerAdmin webmaster@devopsdocker
            DocumentRoot /var/www/devopsdocker/
            ServerName devopsdocker.com
            ServerAlias devopsdocker
            </VirtualHost>
    - name: restart services
      service: name={{item}} state=started
      with_items: 
        - httpd
        - nginx
    - name: Enable services on boot
      service: name={{item}} enabled=yes
      with_items:
        - httpd
        - nginx	
