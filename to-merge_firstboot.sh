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
# start a new dbus session and execute the gsettings command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
   exec dbus-run-session -- bash -c 'gsettings set org.nemo.preferences tooltips-in-icon-view true && gsettings set org.nemo.preferences tooltips-in-list-view true && gsettings set org.nemo.preferences tooltips-on-desktop true && gsettings set org.nemo.preferences tooltips-show-file-type true && gsettings set org.nemo.preferences tooltips-show-mod-date true'
exec dbus-run-session -- bash -c "gsettings set org.cinnamon.desktop.screensaver font-time 'Ubuntu Bold 64'"
exec dbus-run-session -- bash -c 'gsettings set org.cinnamon.desktop.interface buttons-have-icons true'
exec dbus-run-session -- bash -c "gsettings set org.cinnamon system-icon 'distributor-logo' && gsettings set org.cinnamon startup-icon-name 'distributor-logo'"
exec dbus-run-session -- bash -c "gsettings set org.cinnamon app-menu-label 'Explore' && gsettings set org.cinnamon app-menu-icon-name 'distributor-logo'"
exec dbus-run-session -- bash -c "gsettings set org.cinnamon demands-attention-passthru-wm-classes \"['gnome-screenshot', 'lxterminal', 'xfce4-terminal', 'firefox', 'firedoge', 'libreoffice', 'soffice']\"" #need testing. syntax may be wrong

if [ ! -e Pictures/Screenshots ]; then mkdir Pictures/Screenshots; fi
exec dbus-run-session -- bash -c "gsettings set org.gnome.gnome-screenshot auto-save-directory '~/Pictures/Screenshots'"

exec dbus-run-session -- bash -c "gsettings set org.cinnamon.desktop.background picture-uri 'file:///1/img/bg.jpg' && gsettings set org.cinnamon.desktop.background.slideshow image-source 'xml:///usr/share/gnome-background-properties/floflis-backgrounds.xml'"

exec dbus-run-session -- bash -c "gsettings set org.cinnamon favorite-apps \"['firefox.desktop', 'cinnamon-settings.desktop', 'org.gnome.Calculator.desktop', 'sol.desktop', 'remote-viewer.desktop', 'cinnamon-settings-universal-access.desktop']\"" #need testing. syntax may be wrong

exec dbus-run-session -- bash -c "gsettings set org.cinnamon.desktop.interface cursor-theme 'Floflis' && gsettings set org.cinnamon.desktop.interface icon-theme 'Floflis'"
#-
exec dbus-run-session -- bash -c "gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis' && gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis' && gsettings set org.cinnamon.theme name 'Yaru-floflis'"

exec dbus-run-session -- bash -c "gsettings set org.cinnamon.desktop.sound event-sounds true && gsettings set org.cinnamon.desktop.sound volume-sound-enabled true && gsettings set org.cinnamon.desktop.sound volume-sound-file '/1/sounds/Changing volume.ogg'"
#-
exec dbus-run-session -- bash -c "gsettings set org.cinnamon.sounds close-file '/1/sounds/Manipulating windows.ogg' && gsettings set org.cinnamon.sounds login-file '/1/sounds/System Logon.oga' && gsettings set org.cinnamon.sounds logout-file '/1/sounds/Leaving.ogg' && gsettings set org.cinnamon.sounds map-file '/1/sounds/Manipulating windows.ogg' && gsettings set org.cinnamon.sounds maximize-file '/1/sounds/Manipulating windows.ogg' && gsettings set org.cinnamon.sounds minimize-file '/1/sounds/Manipulating windows.ogg' && gsettings set org.cinnamon.sounds notification-file '/1/sounds/Notification.oga' && gsettings set org.cinnamon.sounds plug-file '/1/sounds/Inserting device.ogg' && gsettings set org.cinnamon.sounds switch-file '/1/sounds/Switching workspace.ogg' && gsettings set org.cinnamon.sounds tile-file '/1/sounds/Manipulating windows.ogg' && gsettings set org.cinnamon.sounds unmaximize-file '/1/sounds/Manipulating windows.ogg' && gsettings set org.cinnamon.sounds unplug-file '/1/sounds/Removing device.ogg'"
#-
exec dbus-run-session -- bash -c 'gsettings set org.cinnamon.sounds close-enabled true && gsettings set org.cinnamon.sounds logout-enabled true && gsettings set org.cinnamon.sounds minimize-enabled true && gsettings set org.cinnamon.sounds notification-enabled true && gsettings set org.cinnamon.sounds plug-enabled true && gsettings set org.cinnamon.sounds switch-enabled true && gsettings set org.cinnamon.sounds tile-enabled true && gsettings set org.cinnamon.sounds unmaximize-enabled true && gsettings set org.cinnamon.sounds unplug-enabled true && gsettings set org.cinnamon.sounds map-enabled false && gsettings set org.cinnamon.sounds maximize-enabled false'
EOF

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
                # start a new dbus session and execute the dconf command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
   exec dbus-run-session -- bash -c 'dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < /tmp/org-gnome-terminal-legacy-profiles'
EOF
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
   sudo chmod -R a+rwX /1/config && sudo chown -R $pure:$pure /1/config #from https://askubuntu.com/a/693427
   sudo chmod -R a+rwX /usr/share/ubiquity-slideshow && sudo chown -R $pure:$pure /usr/share/ubiquity-slideshow
   sudo chmod -R a+rwX /usr/lib/floflis/layers/soil/to-merge && sudo chown -R $pure:$pure /usr/lib/floflis/layers/soil/to-merge
done
