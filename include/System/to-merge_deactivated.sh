#echo "Installing xdotool..."
#$maysudo apt install xdotool
#echo "Is xdotool still useful?" # inspire on how firedoge is installed and how it opens an app without blocking the rest of script

#ipfs init
##bash ipfsdaemon > ipfs.log &
#ipfs daemon
#xdotool key Ctrl+d
#xdotool key Ctrl+d
# on Cubic, need to have IPFS running on host - until its fixed

# HOME LAYER -->
# Install IPFS-Desktop:
#echo "Installing IPFS Desktop..."
#if [ "$flofarch" = "amd64" ]; then
#   $maysudo dpkg -i include/deb\ packages/ipfs-desktop-0.25.0-linux-amd64.deb
#   rm -f /opt/IPFS\ Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs/ipfs && sudo ln -s /usr/bin/ipfs /opt/IPFS\ Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs
#   $maysudo cat >> /usr/bin/ipfsdaemon << ENDOFFILE
#ipfs-desktop
#ENDOFFILE
#   $maysudo chmod +x /usr/bin/ipfsdaemon
#fi
# <-- HOME LAYER

#echo "Installing ipfs-handle..." #this doesnt works yet
#$maysudo cat > /usr/share/applications/ipfs-handle-link.desktop <<EOF
#[Desktop Entry]
#Type=Application
#Name=Handler for ipfs:// URIs
#Exec=xdg-open %u
#StartupNotify=false
#MimeType=x-scheme-handler/ipfs;
#NoDisplay=true
#EOF
#$maysudo cat >> /usr/share/applications/x-cinnamon-mimeapps.list <<EOF
#x-scheme-handler/ipfs=firefox.desktop;chromium.desktop;
#EOF
#echo "ipfs-handle doesn't works, yet."

# TEMPORARILY DEACTIVATE UNTIL MITIGATED ISSUES ------------>
#echo "Installing Finance category..." #this doesnt works yet
#$maysudo cat > /usr/share/desktop-directories/Finance.directory <<EOF
#[Desktop Entry]
#Name=Finance
#Comment=Financial applications
## Translators: Do NOT translate or transliterate this text (this is an icon file name)!
#Icon=ethereum
#Type=Directory
#X-Ubuntu-Gettext-Domain=gnome-menus-3.0
#EOF
#$maysudo cat >> /etc/xdg/menus/cinnamon-applications.menu <<EOF
#<Menu><Name>Finance</Name><Directory>Finance.directory</Directory></Menu>
#EOF
#$maysudo cat > /usr/share/desktop-directories/cinnamon-finance.directory <<EOF
#[Desktop Entry]
#Name=Finance
#Comment=Financial applications
## Translators: Do NOT translate or transliterate this text (this is an icon file name)!
#Icon=ethereum
#Type=Directory
#EOF
#$maysudo cat >> /etc/xdg/menus/cinnamon-applications.menu <<EOF
#<Menu>
#    <Name>Finance</Name>
#    <Directory>cinnamon-finance.directory</Directory>
#</Menu>
#EOF
#echo "Finance category doesn't works, yet."
## now it probably works, thanks to help from https://forums.linuxmint.com/viewtopic.php?t=291101
# <-------- TEMPORARILY DEACTIVATE UNTIL MITIGATED ISSUES

#echo "Installing Money Manager Ex..." #this doesnt works yet
#$maysudo snap install mmex
#echo "Money Manager Ex doesn't works, yet."

#echo "Installing Openshot video editor..."
#$maysudo add-apt-repository ppa:openshot.developers/ppa -y && sudo apt-get update -y && sudo apt-get install openshot-qt -y

# UBUNTUCINNAMON TEMPORARILY DISABLE ---->
#echo "Installing icons..."
#cd include/img/icons/Floflis
#if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/icons.git .; fi
#if [ -e .git ]; then git pull; fi
#git checkout -f
#cd ..
#$maysudo rsync -av Floflis /usr/share/icons
#cd Floflis
##rm -f .gitattributes #use noah to exclude everything except .git
##rm -f tasks.txt
##rm -f 'personal research.txt'
##rm -f index.theme
##rm -f icon-theme.cache
##rm -f cursor.theme
##rm -rf 8x8 && rm -rf 8x8@2x && rm -rf 16x16 && rm -rf 16x16@2x && rm -rf 22x22 && rm -rf 24x24 && rm -rf 24x24@2x && rm -rf 32x32 && rm -rf 32x32@2x && rm -rf 48x48 && rm -rf 48x48@2x && rm -rf 64x64 && rm -rf 96x96 && rm -rf 128x128 && rm -rf 256x256 && rm -rf 256x256@2x && rm -rf 512x512 && rm -rf cursors && rm -rf scalable && rm -rf scalable-max-32
#cd "$SCRIPTPATH"
#if [ -f /tmp/cubicmode ]; then
#   $maysudo rm -rf /usr/share/icons/Floflis/.git
#fi

#if [ ! -e /usr/share/icons/Yaru ]; then
#   tar -xzf include/img/icons/Yaru.tar.gz
#   $maysudo rsync -av Yaru /usr/share/icons
#   $maysudo rm -rf Yaru
#fi

#if [ -e /usr/share/icons/Yaru ]; then
#       echo "Proceeding with the install of Floflis icons..." #futurely, Floflis icons will be an separate package with its own installer
#       if [ ! -e /usr/share/icons/ubuntu ]; then $maysudo mkdir /usr/share/icons/ubuntu; fi
#       $maysudo mv -f /usr/share/icons/Yaru /usr/share/icons/ubuntu/Yaru
#       $maysudo ln -s /usr/share/icons/Floflis /usr/share/icons/Yaru
#       # echo "de-duplicing icons in hicolor..." sudo rm -f cinnamon-preferences-color.png && sudo rm -f csd-color.png && sudo ln -s preferences-color.png cinnamon-preferences-color.png && sudo ln -s preferences-color.png csd-color.png
#       echo "de-duplicing some icons in Yaru..."
#       echo "de-duplicing some icons in Yaru/apps..."
#       $maysudo cp -f include/img/icons/to-merge_floflis-icons.sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/256x256@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/256x256/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/48x48@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/48x48/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/32x32@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/32x32/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/24x24@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/24x24/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/16x16@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/16x16/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       #cd "$(dirname "${BASH_SOURCE[0]}")" #should work but isnt working
#       cd "$SCRIPTPATH"
#       $maysudo rm -f /tmp/to-merge_floflis-icons.sh
#fi
# <---- UBUNTUCINNAMON TEMPORARILY DISABLE

#echo "Installing Cinnamon 4.8..."
#$maysudo add-apt-repository ppa:wasta-linux/cinnamon-4-8
#$maysudo apt update
#$maysudo apt install cinnamon-desktop-environment
##https://www.tecmint.com/install-cinnamon-desktop-in-ubuntu-fedora-workstations/

#$maysudo apt --fix-broken install
#- detect ubuntu cinnamon remix otherwise install cinnamon normally

#echo "Installing main theme..."
#tar -xzf include/Theme/Eleganse-Floflis.tar.gz
#$maysudo rsync -av Eleganse-Floflis /usr/share/themes
#$maysudo rm -rf Eleganse-Floflis
##$maysudo rm -rf /usr/share/themes/Eleganse-Floflis/.git
##-
#tar -xzf include/Theme/Adapta.tar.gz
#$maysudo rsync -av Adapta /usr/share/themes
#$maysudo rm -rf Adapta
##-
#tar -xzf include/Theme/Adapta-Nokto.tar.gz
#$maysudo rsync -av Adapta-Nokto /usr/share/themes
#$maysudo rm -rf Adapta-Nokto

# temporarily disable "Installing logon design" until fixed for Ubuntu 22.10 ---->
#echo "Installing logon design..."
#cd include/Theme/ubuntu-gdm-set-background
#if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/ubuntu-gdm-set-background.git .; fi
#if [ -e .git ]; then git pull; fi
#git checkout -f
#$maysudo ./ubuntu-gdm-set-background --gradient horizontal \#F19399 \#61EACA
##-from https://www.omgubuntu.co.uk/2022/01/change-ubuntu-login-screen-background
##rm -f ubuntu-gdm-set-background #use noah to exclude everything except .git
##rm -f README.md
##rm -f LICENSE
#cd "$SCRIPTPATH"
# <---- temporarily disable "Installing logon design" until fixed for Ubuntu 22.10
#-

## HOME LAYER -->
#echo "Installing Etcher (you are still great, Rufus)..."
#if [ "$flofarch" = "amd64" ]; then
#   $maysudo dpkg -i include/deb\ packages/balena-etcher_1.14.3_amd64.deb
#   apt --fix-broken install
#   
#fi
## <-- HOME LAYER

#echo "Installing Audacity (12.0 MB download; 52.2 MB installed)..."
#$maysudo apt install audacity

#echo "Installing OBS (17.0 MB download; 85.8 MB installed)..."
#$maysudo apt install obs-studio
