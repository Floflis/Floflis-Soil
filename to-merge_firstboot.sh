#!/bin/bash

echo "This is the first boot (Soil/to-merge)."
#sudo mv /usr/lib/floflis/layers/core/firstlogon.sh /home
#sudo mv /usr/lib/floflis/layers/core/firstlogonroot.sh /home
#sudo chmod +x /home/firstlogon.sh
#sudo chmod +x /home/firstlogonroot.sh
cd /home
for D in `find . -mindepth 1 -maxdepth 1 -type d`
do
   pure=$(echo "${D}" | tr -d "/" | tr -d ".")
   cd ${D}
   
   echo "Setting up Cinnamon data..."
if [ ! -e /home/${pure}/.config/cinnamon ]; then mkdir /home/${pure}/.config/cinnamon; fi
if [ ! -e /home/${pure}/.config/cinnamon/spices ]; then mkdir /home/${pure}/.config/cinnamon/spices; fi
#tar -C /home/${flouser}/.cinnamon/configs -xzf /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-.cinnamon-configs.tar.gz
rsync -av /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-.cinnamon-configs/. /home/${pure}/.config/cinnamon/spices

cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Cinnamon/usr-share-cinnamon/extensions
#-
cd buildmark
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FloflisPull/buildmark.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
zombiespices install
#-
cd ..
cd nftmark
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/nftmark.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
zombiespices install
#cd "$SCRIPTPATH"
cd ${D}

echo "Building your desktop experience..."
cat >> /tmp/org-cinnamon <<EOF
[/]
enabled-applets=['panel1:right:12:cornerbar@cinnamon.org:1', 'panel1:left:1:search-box@mtwebster:16', 'panel1:left:2:grouped-window-list@cinnamon.org:2', 'panel1:right:1:systray@cinnamon.org:3', 'panel1:right:2:xapp-status@cinnamon.org:4', 'panel1:right:3:notifications@cinnamon.org:5', 'panel1:right:4:printers@cinnamon.org:6', 'panel1:right:5:removable-drives@cinnamon.org:7', 'panel1:right:6:keyboard@cinnamon.org:8', 'panel1:right:7:network@cinnamon.org:9', 'panel1:right:8:sound@cinnamon.org:10', 'panel1:right:9:power@cinnamon.org:11', 'panel1:right:11:calendar@cinnamon.org:12', 'panel1:right:10:weather@mockturtl:13', 'panel1:left:0:CinnVIIStarkMenu@NikoKrause:14']
enabled-extensions=['transparent-panels@germanfr', 'buildmark@floflis']
next-applet-id=15
panel-edit-mode=false
panel-zone-symbolic-icon-sizes='[{"panelId": 1, "left": 28, "center": 28, "right": 16}]'
panels-height=['1:40']

[desktop/a11y/applications]
screen-keyboard-enabled=false
screen-reader-enabled=false

[desktop/a11y/mouse]
dwell-click-enabled=false
dwell-threshold=10
dwell-time=1.2
secondary-click-enabled=false
secondary-click-time=1.2

[desktop/background]
picture-options='zoom'
picture-uri='file:///1/img/bg.png'

[desktop/background/slideshow]
delay=15
image-source='xml:///usr/share/gnome-background-properties/floflis-backgrounds.xml'

[desktop/interface]
cursor-theme='Floflis'
gtk-theme='Yaru-cinnamon-dark'
icon-theme='Floflis'
toolkit-accessibility=false

[desktop/sound]
event-sounds=true
volume-sound-enabled=true
volume-sound-file='/1/sounds/Changing volume.ogg'

[desktop/wm/preferences]
theme='Yaru-cinnamon-dark'

[settings-daemon/peripherals/keyboard]
numlock-state='off'

[sounds]
close-enabled=true
close-file='/1/sounds/Manipulating windows.ogg'
login-file='/1/sounds/System Logon.oga'
logout-enabled=true
logout-file='/1/sounds/Leaving.ogg'
map-enabled=false
map-file='/1/sounds/Manipulating windows.ogg'
maximize-enabled=false
maximize-file='/1/sounds/Manipulating windows.ogg'
minimize-enabled=true
minimize-file='/1/sounds/Manipulating windows.ogg'
notification-enabled=true
notification-file='/1/sounds/Notification.oga'
plug-enabled=true
plug-file='/1/sounds/Inserting device.ogg'
switch-enabled=true
switch-file='/1/sounds/Switching workspace.ogg'
tile-enabled=true
tile-file='/1/sounds/Manipulating windows.ogg'
unmaximize-enabled=true
unmaximize-file='/1/sounds/Manipulating windows.ogg'
unplug-enabled=true
unplug-file='/1/sounds/Removing device.ogg'

[theme]
name='Yaru-cinnamon-dark'
EOF
# start a new dbus session and execute the dconf command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
   exec dbus-run-session -- bash -c 'dconf load /org/cinnamon/ < /tmp/org-cinnamon'
EOF
rm -f /tmp/org-cinnamon

cat >> /tmp/org-nemo-desktop <<EOF
[/]
computer-icon-visible=true
home-icon-visible=true
network-icon-visible=false
show-desktop-icons=true
trash-icon-visible=true
volumes-visible=false
EOF
# start a new dbus session and execute the dconf command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
   exec dbus-run-session -- bash -c 'dconf load /org/nemo/desktop/ < /tmp/org-nemo-desktop'
EOF
rm -f /tmp/org-nemo-desktop

echo "Installing the \"Starshell\" package..."
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Terminal/starshell
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/starshell.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f README.md
#rm -f shit
#rm -f .gitmeta
cd ${D}

# to-merge>
#             if [ -f /usr/lib/floflis/layers/soil/firstlogon.sh ];then
#                installtermfont(){
                cat >> /tmp/org-gnome-terminal-legacy-profiles <<EOF
[/]
custom-command='nu'
login-shell=false
use-custom-command=true
bold-is-bright=true
font='FantasqueSansMono Nerd Font 12'
use-system-font=false
background-color='#282A36'
bold-color='#6E46A4'
bold-color-same-as-fg=false
foreground-color='#F8F8F2'
palette=['#262626', '#E356A7', '#42E66C', '#E4F34A', '#9B6BDF', '#E64747', '#75D7EC', '#EFA554', '#7A7A7A', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C']
use-theme-colors=false
EOF
                exec dbus-run-session -- bash -c 'dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < /tmp/org-gnome-terminal-legacy-profiles'
                rm -f /tmp/org-gnome-terminal-legacy-profiles
#}
#                echo "You have to logout, so changes will take effect."
#                echo "Save any work you did (only if you did)."
#                echo "Logout? [Y/n]"
#                read logoutinput;case $logoutinput in [nN]) break ;; [yY]) installtermfont;cinnamon-session-quit --logout --force; esac
#fi
# <to-merge
   
#   if [ ! -e .config ]; then mkdir .config; fi
#   if [ ! -e .config/autostart ]; then mkdir .config/autostart; fi
#   cd .config/autostart
#   cat > /home/$pure/.config/autostart/firstlogon.sh << ENDOFFILE
#[Desktop Entry]
#Type=Application
#Exec=gnome-terminal --tab --title="Welcome to Floflis! 👭" -- /bin/sh -c 'cd /home; sh ./firstlogon.sh; exec bash'
#Hidden=false
#NoDisplay=false
#X-GNOME-Autostart-enabled=true
#Name[en_US]=FirstLogon
#Name=FirstLogon
#Comment[en_US]=
#Comment=
#Icon=utilities-terminal
#StartupNotify=true
#Terminal=false
#
#ENDOFFILE
#   sudo chmod -R a+rwX /home/$pure/.config/autostart && sudo chown $pure:$pure /home/$pure/.config/autostart
#   sudo chown $pure:$pure /home/$pure/.local/share/gvfs-metadata/home*
#   sudo chmod +x /home/$pure/.config/autostart/firstlogon.sh
#   sudo chown $pure:$pure /home/$pure/.config/autostart/firstlogon.sh
#   cd .config/autostart
#   sudo mv /home/$pure/.config/autostart/firstlogon.sh /home/$pure/.config/autostart/firstlogon.desktop
#   sudo chown $pure:$pure /home/$pure/.config/autostart/firstlogon.desktop
#   cd ..
#   cd ..
#   echo "- Cleanning install..."
#   sudo rm -rf /home/$pure/.config/autostart/firstlogon.sh
   
   cd ..
   sudo chmod -R a+rwX ${D} && sudo chown $pure:$pure ${D}
   sudo chmod -R a+rwX /1 && sudo chown $pure:$pure /1
   sudo chmod -R a+rwX /usr/share/ubiquity-slideshow && sudo chown $pure:$pure /usr/share/ubiquity-slideshow
   sudo chmod -R a+rwX /usr/lib/floflis/layers/soil/to-merge && sudo chown $pure:$pure /usr/lib/floflis/layers/soil/to-merge
done
