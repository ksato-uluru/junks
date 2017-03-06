FROM debian:jessie

RUN perl -pi -e 's/httpredir/ftp.jp/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install aptitude emacs24-nox python curl git byobu autoconf file g++ gcc libc-dev make pkg-config re2c ca-certificates libedit2 libsqlite3-0 libxml2 xz-utils libicu52 unzip libcurl4-openssl-dev libedit-dev libsqlite3-dev libssl-dev libxml2-dev libicu-dev bzip2 supervisor sudo openjdk-7-jdk bison libjpeg-dev libpng-dev libxpm-dev libgif-dev libmcrypt-dev libreadline-dev libtidy-dev libxslt-dev

EXPOSE 22

RUN useradd -m -d /home/docker -u 1000 -s /bin/bash docker
RUN mkdir /home/docker/.emacs.d
ADD init.el /home/docker/.emacs.d/init.el
ADD Cask /home/docker/.emacs.d/Cask

RUN curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
RUN mv /root/.cask /home/docker

RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN mv /root/.rbenv /home/docker/.rbenv

RUN git clone https://github.com/CHH/phpenv.git /tmp/phpenv
RUN /tmp/phpenv/bin/phpenv-install.sh
RUN git clone https://github.com/CHH/php-build.git /root/.phpenv/plugins/php-build
RUN mv /root/.phpenv /home/docker/.phpenv
RUN perl -pi -e 's|/root/|/home/docker/|g' /home/docker/.phpenv/bin/phpenv
RUN perl -pi -e 's|--with-mysql=mysqlnd\n||g' /home/docker/.phpenv/plugins/php-build/share/php-build/default_configure_options

RUN echo 'export TERM=xterm-256color' >> /home/docker/.bashrc
RUN echo 'export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.phpenv/bin:$HOME/.cask/bin' >> /home/docker/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /home/docker/.bashrc
RUN echo 'eval "$(phpenv init -)"' >> /home/docker/.bashrc

RUN chown -R docker:docker /home/docker
RUN echo 'docker ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'docker:docker' | chpasswd
RUN su docker -c 'cd ~/.emacs.d ; ~/.cask/bin/cask'
RUN su docker -c '/home/docker/.rbenv/bin/rbenv install 2.4.0'
RUN su docker -c '/home/docker/.rbenv/bin/rbenv install jruby-9.1.7.0'
RUN su docker -c '/home/docker/.rbenv/bin/rbenv global 2.4.0'

#RUN su docker -c '/home/docker/.phpenv/bin/phpenv install 7.1.2'
#RUN su docker -c '/home/docker/.phpenv/bin/phpenv global 7.1.2'

CMD ["/usr/bin/supervisord"]
