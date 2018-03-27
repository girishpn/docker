#pull centos from dockerhub
FROM Centos
MAINTAINER girish <mpra07@rediffmail.com)
#install updates and packages apache, nginx, php mod_php and ansible to the image
	#updating centos
VOLUME  /var/www/devopsdocker  /var/www/devopsdocker
RUN  yum -y update && \
    #disable iptables
	systemctl disable firewalld  && \
	#install epel-release for centos
	yum -y install epel-release && \
	#install apache
	yum -y install httpd && \
	# enable apache on boot
	systemctl enable httpd && \
	# start apache service
	systemctl start httpd && \
	# install nginx
	yum -y install nginx && \
	#start nginx service
	systemctl start nginx && \
	#enable nginx on boot
	systemctl enable nginx && \
        #install remi repo to install php7
	 yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
	# install yum utils
	 yum -y install yum-utils && \
	# enable remi repo
	 yum-config-manager --enable remi-php70 && \
	# install apache module for php
	 yum -y yum php-opcache && \
	# install Ansible
	 yum -y install ansible
	 rm -rf /etc/ansible/ansible.cfg
	 rm -rf /etc/ansible/hosts
	 cp /root/ansible.cfg /etc/ansible/
	 cp /root/hosts /etc/ansible/
	 cp /root/devops.yml /etc/ansbile/
	 ansible-playbook /etc/ansible/devops

	

	 
