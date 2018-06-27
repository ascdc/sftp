FROM ubuntu:trusty
MAINTAINER ASCDC <ascdc@gmail.com>

ADD run.sh /run.sh

RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /*.sh && \
	apt-get update && \
	apt-get -y dist-upgrade && \
	apt-get -y install openssh-server pwgen git && \
	mkdir -p /var/run/sshd && \
	sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
	sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config && \
	sed -i "s/PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config && \
	echo "ChrootDirectory /home" >> /etc/ssh/sshd_config && \
	echo "ClientAliveInterval 300" >> /etc/ssh/sshd_config && \
	echo "ClientAliveCountMax 5" >> /etc/ssh/sshd_config && \ 
	rm /usr/bin/apt-get	&& \
	rm /usr/bin/vi && \
	rm /bin/echo && \
	rm /bin/rm 

ENV SFTP_PASS **None**

ENTRYPOINT ["/run.sh"]
