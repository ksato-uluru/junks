FROM python:3.6.0

RUN apt-get update
RUN apt -y install openssh-server sudo supervisor

RUN useradd -m -d /home/docker -u 1000 -s /bin/bash docker
RUN echo 'docker ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'docker:docker' | chpasswd

EXPOSE 22

ADD supervisord.conf /etc/supervisor/supervisord.conf

CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
