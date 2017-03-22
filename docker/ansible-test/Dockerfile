FROM amazonlinux:latest
#FROM centos:7

RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install sudo

RUN useradd -m -d /home/ec2-user -u 1000 -s /bin/bash ec2-user
RUN echo 'ec2-user ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'ec2-user:ec2-user' | chpasswd

# for ansible
#RUN yum -y install python27-devel python27-pip libffi-devel openssl-devel

# for sshd
RUN yum -y install openssh-server
EXPOSE 22
RUN sshd-keygen
RUN /etc/init.d/sshd start

# for mysql
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

CMD ["/sbin/init"]
