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
   
# start a new dbus session and execute the dconf command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
   exec dbus-run-session -- bash -c 'bash /usr/lib/cinnamobile/set_desktop.sh'
EOF
   
   echo "Setting up Cinnamon data..."
if [ ! -e /home/${pure}/.config/cinnamon ]; then mkdir /home/${pure}/.config/cinnamon; fi
if [ ! -e /home/${pure}/.config/cinnamon/spices ]; then mkdir /home/${pure}/.config/cinnamon/spices; fi
#tar -C /home/${flouser}/.cinnamon/configs -xzf /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-.cinnamon-configs.tar.gz
rsync -av /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-.cinnamon-configs/. /home/${pure}/.config/cinnamon/spices

echo "Building your desktop experience [part 2/2]..."
# start a new dbus session and execute the gsettings command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
exec dbus-run-session -- bash -c 'if [ ! -e Pictures/Screenshots ]; then mkdir Pictures/Screenshots; fi; dconf write /org/gnome/gnome-screenshot/auto-save-directory "'~/Pictures/Screenshots'"'
EOF

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
   sudo chmod -R a+rwX /home/$pure/.config/cinnamon && sudo chown -R $pure:$pure /home/$pure/.config/cinnamon
done
