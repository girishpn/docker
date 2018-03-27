            DevOps Technical Challenge - UPDATES


As it is assigned, following actions are scripted and updated in git.

1. A docker file created to pull Centos image from docker hub,mount the volume from host machine, and install the packages Nginx,Apache,php & ansible.

2. Ansible not used as Entrypoint and CMD in dockerfile. Configurations and playbooks can be implemented once the docker container made avail in git, which is in progress. 

3. Systemctl is not enabled via dockerfile, so services have to be enabled/disabled from ansible playbook as the last part of deployment.

4. Reverse proxy and URL rewrite with Nginx and Appache under troubleshoot because of permission issue. Need to test it with templates

--------------------------------------------------------------

DevOps Technical Challenge 
Create a repository in Github with README instructions for a Docker container or Docker Compose configuration that has the following specifications:

1. Based on CentosOS 7 
2. Installs nginx 
3. Installs Apache, PHP 7 and mod_php
4. Installs Ansible
5. Using Ansible as an entry point, run scripts that:
   a. Configure nginx to run on port 80
      1. configure nginx to serve static files from Document root mounted as a docker bind volume
   	  2. add miscellaneous files to test with for Document root to the directory used as the docker bind volume
   	  3. reverse proxy files that are not a css, jpg, png or js file to Apache on port 8080
   b. Configure Apache to run on port 8080
      1. create a phpinfo test page in the Document root
      2. create a URL rewrite rule that redirects all requests that do not have the X-Forwarded-Proto header set to https to redirect to an https version of that URL
      3. Using a LocationMatch directive, protect the URL pattern, "/protected" with basic authentication; provide credentials
      4. For files with a eot,ttf,otf,woff and woff2 extensions, create a configuration that enables CORS and allows the OPTIONS method
6. Provide the curl commands that allows nginx and Apache to be tested with each one of these conditions
7. In Github, all of these configurations should exist in a git branch named "CFR"
8. Use templates for the web server configurations









