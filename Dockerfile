#
#pull centos from dockerhub
FROM centos:7
MAINTAINER girish <mpra07@rediffmail.com)
#install updates and packages apache, nginx, php mod_php and ansible to the image
	#updating centos
#VOLUME  /var/www/devopsdocker  /var/www/devopsdocker
RUN  yum -y update && \
    #disable iptables
	systemctl disable firewalld  && \
	#install epel-release for centos
	yum -y install epel-release && \
	#install apache
	# steps to enable systemctl in centos container
	(cd /lib/systemd/system/sysinit.target.wants/; for i in ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); 
	rm -f /lib/systemd/system/multi-user.target.wants/;
	rm -f /etc/systemd/system/.wants/;
	rm -f /lib/systemd/system/local-fs.target.wants/; 
	rm -f /lib/systemd/system/sockets.target.wants/udev; 
	rm -f /lib/systemd/system/sockets.target.wants/initctl; 
	rm -f /lib/systemd/system/basic.target.wants/;
	rm -f /lib/systemd/system/anaconda.target.wants/*;
	#Then build the container using in the dir you have created the file (be sure no other files are inside, as they will be taken into the context and may cause troubles )
	#docker build --rm -t c7-systemd . (c7-systemd can be replaced with other name)
	#Then run the image with:
	#docker run -itd --privileged --name=yourName c7-systemd
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
	# remove default ansible config files 
	 rm -rf /etc/ansible/ansible.cfg
	 rm -rf /etc/ansible/hosts
	# copy updated ansible file from which has to be put in /root directory in host system  
	 cp /root/ansible.cfg /etc/ansible/
	 cp /root/hosts /etc/ansible/
	 cp /root/devops.yml /etc/ansbile/
	 ansible-playbook /etc/ansible/devops
	
	

	 
