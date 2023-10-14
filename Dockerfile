FROM kasmweb/kali-rolling-desktop:1.14.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

COPY background.png /usr/share/extra/backgrounds/bg_default.png

RUN usermod -l cscosu kasm-user
RUN chsh -s /bin/zsh cscosu
RUN echo 'cscosu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN echo "/usr/bin/desktop_ready && sleep 2 && xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/last-image -s /usr/share/extra/backgrounds/bg_default.png && /usr/bin/qterminal" > $STARTUPDIR/custom_startup.sh && \
    chmod +x $STARTUPDIR/custom_startup.sh

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV SHELL /bin/zsh
ENV HOME /home/cscosu
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
