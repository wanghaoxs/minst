FROM ubuntu:18.04
#-----------------------------------------------------------------------------------------------------------------------
# replace default repo.
RUN echo "\
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse\n\
" > /etc/apt/sources.list \
&& rm -rf /etc/apt/sources.list.d/* \
&& apt update

# install common.
RUN set -x \
&& apt install -y wget \
&& apt install -y git \
&& apt install -y vim \
&& echo "alias ll='ls -alF'">>~/.bashrc \
&& echo "end"

# install ssh.
RUN apt install -y openssh-server \
&& echo "\
sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config\n\
sed -i 's/PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config\n\
sed -i 's/#StrictModes.*/StrictModes no/' /etc/ssh/sshd_config\n\
sed -i 's/StrictModes.*/StrictModes no/' /etc/ssh/sshd_config\n\
sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config\n\
sed -i 's/PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config\n\
sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config\n\
sed -i 's/PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config\n\
sed -i 's/#AuthorizedKeysFile.*/AuthorizedKeysFile .ssh\/authorized_keys/' /etc/ssh/sshd_config\n\
sed -i 's/AuthorizedKeysFile.*/AuthorizedKeysFile .ssh\/authorized_keys/' /etc/ssh/sshd_config\n\
sed -i 's/#GSSAPIAuthentication.*/GSSAPIAuthentication no/' /etc/ssh/sshd_config\n\
sed -i 's/GSSAPIAuthentication.*/GSSAPIAuthentication no/' /etc/ssh/sshd_config\n\
sed -i 's/#UsePAM.*/UsePAM no/' /etc/ssh/sshd_config\n\
sed -i 's/UsePAM.*/UsePAM no/' /etc/ssh/sshd_config\n\
sed -i 's/#UseDNS.*/UseDNS no/' /etc/ssh/sshd_config\n\
sed -i 's/UseDNS.*/UseDNS no/' /etc/ssh/sshd_config\n\
" > /config_sshd.sh \
&& bash /config_sshd.sh \
&& echo 'root:cloud1234' | chpasswd \
&& echo "end"

# add entrypoint.
RUN set -x \
&& echo '#!/usr/bin/env bash' >/usr/bin/ubuntu_daemon \
&& echo "mkdir /run/sshd"    >>/usr/bin/ubuntu_daemon \
&& echo "/usr/sbin/sshd&"    >>/usr/bin/ubuntu_daemon \
&& echo "sleep infinity"     >>/usr/bin/ubuntu_daemon \
&& chmod +x /usr/bin/ubuntu_daemon
ENTRYPOINT ["ubuntu_daemon"]
WORKDIR /root
