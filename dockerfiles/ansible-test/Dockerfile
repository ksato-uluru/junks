#FROM amazonlinux:latest
FROM centos:7

RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install sudo

RUN useradd -m -d /home/docker -u 1000 -s /bin/bash docker
RUN echo 'docker ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'docker:docker' | chpasswd

CMD ["/bin/bash"]