FROM debian:jessie

RUN perl -pi -e 's/httpredir/ftp.jp/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install aptitude emacs24-nox python curl git byobu autoconf file g++ gcc libc-dev make pkg-config re2c ca-certificates libedit2 libsqlite3-0 libxml2 xz-utils libicu52 unzip libcurl4-openssl-dev libedit-dev libsqlite3-dev libssl-dev libxml2-dev libicu-dev bzip2 supervisor sudo openjdk-7-jdk bison libjpeg-dev libpng-dev libxpm-dev libgif-dev libmcrypt-dev libreadline-dev libtidy-dev libxslt-dev libbz2-dev

EXPOSE 22

RUN useradd -m -d /home/docker -u 1000 -s /bin/bash docker
RUN mkdir /home/docker/.emacs.d
ADD init.el /home/docker/.emacs.d/init.el
ADD Cask /home/docker/.emacs.d/Cask

RUN curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
RUN mv /root/.cask /home/docker

RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

RUN git clone https://github.com/pyenv/pyenv.git /usr/local/pyenv

RUN git clone https://github.com/CHH/phpenv.git /tmp/phpenv
RUN /tmp/phpenv/bin/phpenv-install.sh
RUN git clone https://github.com/CHH/php-build.git /root/.phpenv/plugins/php-build
RUN mv /root/.phpenv /usr/local/phpenv
RUN perl -pi -e 's|/root/.phpenv|/usr/local/phpenv|g' /usr/local/phpenv/bin/phpenv
RUN perl -pi -e 's|--with-mysql=mysqlnd\n||g' /home/docker/.phpenv/plugins/php-build/share/php-build/default_configure_options

RUN echo 'export TERM=xterm-256color' >> /home/docker/.bashrc
RUN echo 'export PATH=$PATH:$HOME/.cask/bin' >> /home/docker/.bashrc

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /home/docker/.bashrc
RUN echo 'export PATH=$RBENV_ROOT/bin:$PATH' >> /home/docker/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /home/docker/.bashrc

RUN echo 'export PYENV_ROOT=/usr/local/pyenv' >> /home/docker/.bashrc
RUN echo 'export PATH=$PYENV_ROOT/bin:$PATH' >> /home/docker/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> /home/docker/.bashrc

RUN echo 'export PHPENV_ROOT=/usr/local/phpenv' >> /home/docker/.bashrc
RUN echo 'export PATH=$PHPENV_ROOT/bin:$PATH' >> /home/docker/.bashrc
RUN echo 'eval "$(phpenv init -)"' >> /home/docker/.bashrc

RUN echo 'cd $HOME' >> /home/docker/.bashrc

RUN chown -R docker:docker /home/docker
RUN chown -R docker:docker /usr/local/rbenv
RUN chown -R docker:docker /usr/local/pyenv
RUN chown -R docker:docker /usr/local/phpenv

RUN echo 'docker ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'docker:docker' | chpasswd
RUN su docker -c 'cd ~/.emacs.d ; ~/.cask/bin/cask'

#RUN /usr/local/rbenv/bin/rbenv install 2.4.0
#RUN /usr/local/rbenv/bin/rbenv install jruby-9.1.7.0
#RUN /usr/local/rbenv/bin/rbenv global 2.4.0

#RUN su docker -c '/usr/local/pyenv/bin/pyenv install 3.6.0'
#RUN su docker -c '/usr/local/pyenv/bin/pyenv global 3.6.0'

#RUN su docker -c '/usr/local/phpenv/bin/phpenv install 7.1.2'
#RUN su docker -c '/usr/local/phpenv/bin/phpenv global 7.1.2'

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
