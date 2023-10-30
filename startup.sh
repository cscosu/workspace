sudo dockerd &

/usr/bin/desktop_ready
sleep 5

xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/last-image -s /usr/share/extra/backgrounds/bg_default.png

/usr/bin/code /home/cscosu/meeting
