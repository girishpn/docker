#pull centos from dockerhub
FROM Centos

#install updates and packages apache, nginx, php mod_php and ansible to the image

#VOLUME  /var/www/devopsdocker  /var/www/devopsdocker
#updating centos
RUN sudo yum -y update && \
       #enable systemd
       RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
       rm -f /lib/systemd/system/multi-user.target.wants/*;\
       rm -f /etc/systemd/system/*.wants/*;\
       rm -f /lib/systemd/system/local-fs.target.wants/*; \
       rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
       rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
       rm -f /lib/systemd/system/basic.target.wants/*;\
       rm -f /lib/systemd/system/anaconda.target.wants/*;
        #disable iptables
	sudo systemctl disable firewalld  && \
	#install epel-release for centos
	sudo yum -y install epel-release && \
	#install apache
	sudo yum -y install httpd && \
	# enable apache on boot
	sudo systemctl enable httpd && \
	# start apache service
	sudo systemctl start httpd && \
	# install nginx
	sudo yum -y install nginx && \
	#start nginx service
	sudo systemctl start nginx && \
	#enable nginx on boot
	sudo systemctl enable nginx && \
        #install remi repo to install php7
	sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
	# install yum utils
	sudo yum -y install yum-utils && \
	# enable remi repo
	sudo yum-config-manager --enable remi-php70 && \
	# install apache module for php
	sudo yum -y yum php-opcache && \
	# install Ansible
	sudo yum -y install ansible
	sudo rm -rf /etc/ansible/ansible.cfg
	sudo rm -rf /etc/ansible/hosts
	sudo cp /root/ansible.cfg /etc/ansible/
	sudo cp /root/hosts /etc/ansible/
	sudo cp /root/devops.yml /etc/ansbile/
	sudo ansible-playbook /etc/ansible/devops

	

	 
