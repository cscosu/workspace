FROM docker.io/kasmweb/kali-rolling-desktop:1.14.0
USER root

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && \
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm -f packages.microsoft.gpg

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y code docker.io

ENV VNCOPTIONS -disableBasicAuth
ENV HOME /home/cscosu
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

# COPY kasmvnc.yaml /etc/kasmvnc/kasmvnc.yaml
COPY background.png /usr/share/extra/backgrounds/bg_default.png

RUN usermod -l cscosu kasm-user
RUN usermod -aG docker cscosu
RUN chsh -s /bin/zsh cscosu
RUN echo 'cscosu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN mkdir /home/cscosu/meeting
COPY vscode-settings.json /home/cscosu/.config/Code/User/settings.json

COPY startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV SHELL /bin/zsh
ENV HOME /home/cscosu
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

RUN pip install pwntools pyshark
RUN code --install-extension ms-azuretools.vscode-docker
RUN code --install-extension ms-vscode.cpptools-extension-pack
RUN code --install-extension ms-python.python
RUN code --install-extension ms-python.black-formatter
