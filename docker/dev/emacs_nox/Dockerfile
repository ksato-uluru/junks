FROM debian:jessie

RUN apt-get update
RUN apt-get -y install aptitude curl git byobu autoconf automake file g++ gcc libc-dev make libncurses-dev bzip2 supervisor sudo libgif-dev libjpeg-dev libgtk-3-dev libwebkitgtk-3.0-dev

EXPOSE 22

RUN useradd -m -d /home/docker -u 1000 -s /bin/bash docker
RUN mkdir /home/docker/.emacs.d
ADD init.el /home/docker/.emacs.d/init.el
ADD Cask /home/docker/.emacs.d/Cask

WORKDIR /usr/src
RUN curl -O http://ftp.gnu.org/gnu/emacs/emacs-25.1.tar.xz
RUN tar xJf emacs-25.1.tar.xz
WORKDIR /usr/src/emacs-25.1
RUN ./configure --disable-largefile --with-x-toolkit=gtk3 \
    --without-toolkit-scroll-bars --without-xaw3d --without-xim \
    --without-compress-install --with-sound=no --without-pop \
    --without-xpm --without-tiff --without-rsvg --without-gconf \
    --without-gsettings --without-selinux --without-gpm \
    --without-makeinfo --with-x --with-modules --with-xwidgets && make install

RUN curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
RUN mv /root/.cask /home/docker

RUN chown -R docker:docker /home/docker
RUN su docker -c 'cd ~/.emacs.d ; ~/.cask/bin/cask'

ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
