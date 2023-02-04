#!/bin/bash

#- Floflis main Ubuntu ISO will use Ultimate layer. For Home layer, different ISO base: https://help.ubuntu.com/community/Installation/MinimalCD https://www.edivaldobrito.com.br/instalar-ambiente-cinnamon-3-0-no-ubuntu-16-04/

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
flouser=$(logname)

# load definitions & settings
. /usr/lib/floflis/./config

# would detect fakeroot 
#for path in ${LD_LIBRARY_PATH//:/ }; do
#   if [[ "$path" == *libfakeroot ]]
#      then
#         echo "You're using fakeroot. Floflis won't work."
#         exit
#fi
#done
is_root=false
if [ "$([[ $UID -eq 0 ]] || echo "Not root")" = "Not root" ]
   then
      is_root=false
   else
      is_root=true
fi
maysudo=""
if [ "$is_root" = "false" ]
   then
      maysudo="sudo"
   else
      maysudo=""
fi

export maysudo

sudo apt upgrade
sudo apt-get autoremove
sudo apt-get autoclean
#-from https://elias.praciano.com/2014/08/apt-get-quais-as-diferencas-entre-autoremove-autoclean-e-clean/

#- attempt to fix Cubic's custom name:
$maysudo sed -i 's/^PRETTY_NAME=" .*$/PRETTY_NAME=" Floflis 19 build 2302_1 'Eusoumafoca'"/' /usr/lib/os-release
$maysudo sed -i 's/^DISTRIB_DESCRIPTION=" .*$/DISTRIB_DESCRIPTION=" Floflis 19 build 2302_1 'Eusoumafoca'"/' /etc/lsb-release
# have to get it from config or json
if [ ! -f /etc/floflis-release ]; then $maysudo touch /etc/floflis-release; fi

echo "Installing unzip..."
$maysudo apt install unzip

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

echo "Installing GDevelop..."
#      if [ "$flofarch" = "386" ]; then
#         tar -xzf include/HTML5Apps/386.tar.gz
#         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
#         $maysudo mv go-ipfs/ipfs /usr/bin
#         $maysudo rm -rf go-ipfs
#         chmod +x /usr/bin/ipfs
#         echo "Testing if IPFS works:"
#         ipfs
#fi
#-
if [ "$flofarch" = "amd64" ]; then
   tar -xzf include/HTML5Apps/gdevelop_amd64.tar.gz
   $maysudo rsync -av gdevelop /1/apps
   chmod +x /1/apps/gdevelop/gdevelop
   rm -rf gdevelop
   $maysudo cat > /usr/bin/gdevelop <<EOF
#!/bin/bash

cd /1/apps/gdevelop/
./gdevelop
EOF
   $maysudo chmod +x /usr/bin/gdevelop
   $maysudo cat > /usr/share/applications/gdevelop.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=GDevelop
Comment=Make games easily even if you don't know to program; even your grandma can.
Type=Application
Exec=gdevelop
Icon=gdevelop
Categories=Programming;Games;
Keywords=programming;games;event-sheet;development;
EOF
fi

#echo "Installing Money Manager Ex..." #this doesnt works yet
#$maysudo snap install mmex
#echo "Money Manager Ex doesn't works, yet."

#echo "Installing Openshot video editor..."
#$maysudo add-apt-repository ppa:openshot.developers/ppa -y && sudo apt-get update -y && sudo apt-get install openshot-qt -y

echo "Installing Minetest..."
$maysudo apt install minetest

echo "Installing gbrainy..."
$maysudo apt install gbrainy
#$maysudo apt install supertux

echo "Installing Photos..."
$maysudo apt install gnome-photos
echo "Installing Clock..."
$maysudo apt install gnome-clocks
echo "Installing KeePassXC..."
$maysudo apt install keepassxc
echo "Installing Weather..."
$maysudo apt install gnome-weather

echo "Installing webcam software..."
$maysudo apt update
$maysudo apt install cheese
#from https://linuxconfig.org/how-to-test-webcam-on-ubuntu-22-04-jammy-jellyfish
#-
echo "Installing Character Map..."
$maysudo apt install gnome-characters # 3.456 kB of additional disk space will be used.

$maysudo bash include/Shortcuts/customShortcuts.sh

echo "Installing Weblink apps/shortcuts..."
cd include/Shortcuts/WeblinkApps
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/WeblinkApps.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo bash install.sh
cd "$SCRIPTPATH"

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

echo "Installing branding..."
if [ ! -e /usr/share/cups/data/ubuntu ]; then $maysudo mkdir /usr/share/cups/data/ubuntu; fi
$maysudo mv -f /usr/share/cups/data/default-testpage.pdf /usr/share/cups/data/ubuntu/default-testpage.pdf
$maysudo cp -f include/img/default-testpage.pdf /usr/share/cups/data/default-testpage.pdf

# UBUNTUCINNAMON TEMPORARILY DISABLE ---->
#echo "Installing installer's slideshow..."
#if [ -e /usr/share/ubiquity-slideshow ]; then
#    if [ ! -e /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu; fi
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/screenshots/welcome.png /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/screenshots/photos.png /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu
#-
#    if [ ! -e /usr/share/ubiquity-slideshow/slides/icons/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/icons/ubuntu; fi
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/icons/firefox.png /usr/share/ubiquity-slideshow/slides/icons/ubuntu
#-
#    if [ ! -e /usr/share/ubiquity-slideshow/slides/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/ubuntu; fi
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/welcome.html /usr/share/ubiquity-slideshow/slides/ubuntu
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/music.html /usr/share/ubiquity-slideshow/slides/ubuntu
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/accessibility.html /usr/share/ubiquity-slideshow/slides/ubuntu
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/browse.html /usr/share/ubiquity-slideshow/slides/ubuntu
#-
#    if [ ! -e /usr/share/ubiquity-slideshow/slides/link/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/link/ubuntu; fi
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/background.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/bullet-point.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/arrow-back.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
#    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/arrow-next.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
#-    
#    cd include/System/ubiquity-slideshow
#    if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/ubiquity-slideshow.git .; fi
#    if [ -e .git ]; then git pull; fi
##if failure, get from other sources (add to all other clonable resources)
#    git checkout -f
#    cd ..
#    $maysudo rsync -av ubiquity-slideshow /usr/share
#    cd ubiquity-slideshow
##    rm -f .gitattributes #use noah to exclude everything except .git
##    rm -rf slides
##    rm -f slideshow.conf
#    cd "$SCRIPTPATH"
#fi
# <---- UBUNTUCINNAMON TEMPORARILY DISABLE

echo "Installing img..."
if [ ! -e /1/img ]; then $maysudo mkdir /1/img; fi
#-
$maysudo cp -f include/img/OSlogotype.svg /1/img/OSlogotype.svg
$maysudo cp -f include/img/logo.png /1/img/logo.png

cd include/img/watermarkmaker
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/watermarkmaker.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
bash run.sh
until [ -f watermark.png ]
do
   sleep 1s
done
$maysudo cp -f watermark.png /1/img/watermark.png
rm watermark_template.png
rm watermark.png
cd "$SCRIPTPATH"

#-
if [ ! -e /1/img/networks ]; then $maysudo mkdir /1/img/networks; fi
$maysudo cp -f include/img/networks/ethereum.svg /1/img/networks/ethereum.svg
$maysudo cp -f include/img/networks/polygon.svg /1/img/networks/polygon.svg
$maysudo cp -f include/img/networks/optimism.svg /1/img/networks/optimism.svg
$maysudo cp -f include/img/networks/gnosis.svg /1/img/networks/gnosis.svg
$maysudo cp -f include/img/networks/ronin.svg /1/img/networks/ronin.svg
#-
$maysudo cp -f include/img/token.svg /1/img/token.svg

echo "Installing backgrounds..."
cd include/img/Backgrounds
$maysudo cp -f bg.png /1/img/bg.png
$maysudo cp -f lockscreen.png /1/img/lockscreen.png
#-
if [ ! -e /usr/share/backgrounds/ubuntu ]; then $maysudo mkdir /usr/share/backgrounds/ubuntu; fi

if [ -f /usr/share/backgrounds/Kinetic_Kudu_by_Joshua_T_dark.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Kinetic_Kudu_by_Joshua_T_dark.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Kinetic_Kudu_by_Joshua_T_light.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Kinetic_Kudu_by_Joshua_T_light.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Kudu_Wallpaper_Grey_4096x2304.png ]; then $maysudo mv -f /usr/share/backgrounds/Kudu_Wallpaper_Grey_4096x2304.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png ]; then $maysudo mv -f /usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Obersee_by_Uday_Nakade.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Obersee_by_Uday_Nakade.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Reflection_by_Juliette_Taka.png ]; then $maysudo mv -f /usr/share/backgrounds/Reflection_by_Juliette_Taka.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Saffron_by_Rakesh_Yadav.png ]; then $maysudo mv -f /usr/share/backgrounds/Saffron_by_Rakesh_Yadav.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Sunset_Over_Lake_Lugano_by_Alexey_Kulik.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Sunset_Over_Lake_Lugano_by_Alexey_Kulik.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Twisted_Gradients_by_Gustavo_Brenner.png ]; then $maysudo mv -f /usr/share/backgrounds/Twisted_Gradients_by_Gustavo_Brenner.png /usr/share/backgrounds/ubuntu; fi

if [ ! -e /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntucinnamon ]; then $maysudo mkdir /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntucinnamon; fi

$maysudo mv -f /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntu_cinnamon_kinetic_kudu.jpg /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntucinnamon/ubuntu_cinnamon_kinetic_kudu.jpg
$maysudo ln -s /1/img/bg.png /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntu_cinnamon_kinetic_kudu.jpg
#-
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/BackgroundsImg.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo rsync -av Backgrounds/. /usr/share/backgrounds
#-
$maysudo cp -f floflis-backgrounds.xml /usr/share/gnome-background-properties/floflis-backgrounds.xml
cd "$SCRIPTPATH"

echo "Updating default background..."
if [ ! -e /usr/share/wallpapers/FuturePrototype/debian ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/debian; fi
if [ -e /usr/share/wallpapers/FuturePrototype/contents ]; then $maysudo mv /usr/share/wallpapers/FuturePrototype/contents /usr/share/wallpapers/FuturePrototype/debian/contents; fi
if [ ! -e /usr/share/wallpapers/FuturePrototype/contents ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/contents; fi
if [ ! -e /usr/share/wallpapers/FuturePrototype/contents/images ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/contents/images; fi
if [ -f /usr/share/wallpapers/FuturePrototype/gnome-background.xml ]; then $maysudo mv /usr/share/wallpapers/FuturePrototype/gnome-background.xml /usr/share/wallpapers/FuturePrototype/debian/gnome-background.xml; fi
$maysudo ln -s /1/img/bg.png /usr/share/wallpapers/FuturePrototype/contents/images/1680x1050.png

# Cinnamon pre-installed avatars
$maysudo bash include/img/Avatars/install.sh

echo "Installing sounds..."
if [ ! -e /1/sounds ]; then $maysudo mkdir /1/sounds; fi
$maysudo cp -f include/sounds/presentation.ogg /1/sounds/presentation.ogg

#- Deduplicate Ubuntu's login sound
if [ -f /usr/share/sounds/Yaru/stereo/system-ready.oga ]; then
if [ -f /usr/share/sounds/Yaru/stereo/desktop-login.oga ]; then
$maysudo rm -f /usr/share/sounds/Yaru/stereo/system-ready.oga && $maysudo ln -s 'desktop-login.oga' /usr/share/sounds/Yaru/stereo/system-ready.oga
fi
fi

# Patch alarm clock sound
if [ ! -e /usr/share/sounds/freedesktop/stereo/ubuntu ]; then $maysudo mkdir /usr/share/sounds/freedesktop/stereo/ubuntu; if [ -f /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga ]; then $maysudo mv -f /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga /usr/share/sounds/freedesktop/stereo/ubuntu; fi; fi
$maysudo ln -sf ../../ubuntu/ringtones/Counterpoint.ogg /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga

# BASE LAYER -->
# Base sounds
$maysudo cp -f include/sounds/Base/Changing\ volume.ogg /1/sounds/Changing\ volume.ogg
$maysudo cp -f include/sounds/Base/Inserting\ device.ogg /1/sounds/Inserting\ device.ogg
$maysudo cp -f include/sounds/Base/Leaving.ogg /1/sounds/Leaving.ogg
$maysudo cp -f include/sounds/Base/Manipulating\ windows.ogg /1/sounds/Manipulating\ windows.ogg
$maysudo cp -f include/sounds/Base/Notification.oga /1/sounds/Notification.oga
$maysudo cp -f include/sounds/Base/Removing\ device.ogg /1/sounds/Removing\ device.ogg
$maysudo cp -f include/sounds/Base/Switching\ workspace.ogg /1/sounds/Switching\ workspace.ogg
$maysudo cp -f include/sounds/Base/Starting.oga /1/sounds/Starting.oga

if [ ! -e /usr/share/sounds/Yaru/stereo/ubuntu ]; then $maysudo mkdir /usr/share/sounds/Yaru/stereo/ubuntu; if [ -f /usr/share/sounds/Yaru/stereo/desktop-login.oga ]; then $maysudo mv -f /usr/share/sounds/Yaru/stereo/desktop-login.oga /usr/share/sounds/Yaru/stereo/ubuntu; fi; if [ -f /usr/share/sounds/Yaru/stereo/system-ready.oga ]; then $maysudo mv -f /usr/share/sounds/Yaru/stereo/system-ready.oga /usr/share/sounds/Yaru/stereo/ubuntu; fi; fi
$maysudo ln -s /1/sounds/Starting.oga /usr/share/sounds/Yaru/stereo/desktop-login.oga
# <-- BASE LAYER

# HOME LAYER -->
# Home sounds patch
$maysudo cp -f include/sounds/Base/Home/Dialog.ogg /1/sounds/Dialog.ogg
$maysudo cp -f include/sounds/Base/Home/Navigation.ogg /1/sounds/Navigation.ogg
$maysudo cp -f include/sounds/Base/Home/Notification.oga /1/sounds/Notification.oga
$maysudo cp -f include/sounds/Base/Home/Notification\ Important.flac /1/sounds/Notification\ Important.flac
$maysudo cp -f include/sounds/Base/Home/System\ Logon.oga /1/sounds/System\ Logon.oga
if [ -f /1/sounds/Starting.oga ]; then $maysudo rm -f /1/sounds/Starting.oga; fi
$maysudo ln -s /1/sounds/System\ Logon.oga /1/sounds/Starting.oga
# <-- HOME LAYER

#echo "Installing Cinnamon 4.8..."
#$maysudo add-apt-repository ppa:wasta-linux/cinnamon-4-8
#$maysudo apt update
#$maysudo apt install cinnamon-desktop-environment
##https://www.tecmint.com/install-cinnamon-desktop-in-ubuntu-fedora-workstations/

#$maysudo apt --fix-broken install
#- detect ubuntu cinnamon remix otherwise install cinnamon normally

echo "Installing 'zombiespices'..."
cd include/System/zombiespices
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/zombiespices.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
cd "$SCRIPTPATH"

echo "Installing Cinnamon applets, desklets and extensions..."
cd include/usr-share-cinnamon

if [ ! -e /usr/share/cinnamon ]; then $maysudo mkdir /usr/share/cinnamon; fi

function job_mkCinnSysFolds {
if [ ! -e /usr/share/cinnamon/"$currentspicetype""s" ]; then $maysudo mkdir /usr/share/cinnamon/"$currentspicetype""s"; fi
}

function job_installSpice {
wget -N https://cinnamon-spices.linuxmint.com/files/"$currentspicetype""s"/$currentspice.zip
# from https://serverfault.com/a/379060/923518
if [ -f $currentspice.zip.1 ]; then rm $currentspice.zip; mv $currentspice.zip.1 $currentspice.zip; fi
unzip $currentspice.zip
$maysudo rsync -av "$currentspice"/. /usr/share/cinnamon/"$currentspicetype""s"/$currentspice
rm -r "$currentspice"
}

currentspicetype="applet"
cd "$currentspicetype""s"

job_mkCinnSysFolds

currentspice="CinnVIIStarkMenu@NikoKrause"
currentspicemintid="281"
job_installSpice

currentspice="windowlist@cobinja.de"
currentspicemintid="287"
job_installSpice

currentspice="clean-show-desktop@filipetorresbr"
currentspicemintid="332"
job_installSpice

currentspice="weather@mockturtl"
currentspicemintid="17"
job_installSpice

currentspice="Cinnamenu@json"
currentspicemintid="322"
job_installSpice

currentspicetype="desklet"
cd ..
cd "$currentspicetype""s"

job_mkCinnSysFolds

currentspice="calendar@deeppradhan"
currentspicemintid="40"
job_installSpice

currentspice="bbcwx@oak-wood.co.uk"
currentspicemintid="20"
job_installSpice

currentspice="analog-clock@cobinja.de"
currentspicemintid="7"
job_installSpice

currentspicetype="extension"
cd ..
cd "$currentspicetype""s"

job_mkCinnSysFolds

currentspice="transparent-panels@germanfr"
currentspicemintid="81"
job_installSpice

cd "$SCRIPTPATH"

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
echo "Installing bootscreen logotype..."
if [ ! -e /usr/share/plymouth/ubuntu ]; then $maysudo mkdir /usr/share/plymouth/ubuntu; $maysudo mv -f /usr/share/plymouth/ubuntu-logo.png /usr/share/plymouth/ubuntu; fi
$maysudo cp -f include/img/floflis-logo.png /usr/share/plymouth/ubuntu-logo.png
$maysudo cp -f include/img/floflis-logo.svg /usr/share/plymouth/ubuntu-logo.svg
#-
if [ ! -e /usr/share/plymouth/ubuntucinnamon ]; then $maysudo mkdir /usr/share/plymouth/ubuntucinnamon; $maysudo mv -f /usr/share/plymouth/ubuntucinnamon-logo.png /usr/share/plymouth/ubuntucinnamon; fi
if [ ! -f /usr/share/plymouth/ubuntucinnamon-logo.png ]; then $maysudo ln -s 'ubuntu-logo.png' /usr/share/plymouth/ubuntucinnamon-logo.png; fi
if [ ! -f /usr/share/plymouth/ubuntucinnamon-logo.svg ]; then $maysudo ln -s 'ubuntu-logo.svg' /usr/share/plymouth/ubuntucinnamon-logo.svg; fi
#-
if [ ! -e /usr/share/plymouth/themes/ubuntucinnamon-spinner/ubuntu ]; then $maysudo mkdir /usr/share/plymouth/themes/ubuntucinnamon-spinner/ubuntu; $maysudo mv -f /usr/share/plymouth/themes/ubuntucinnamon-spinner/watermark.png /usr/share/plymouth/themes/ubuntucinnamon-spinner/ubuntu; $maysudo ln -s ../../ubuntu-logo.png /usr/share/plymouth/themes/ubuntucinnamon-spinner/watermark.png; fi


# Install geth:
#- x32 is not available as ethereal isn't available for x32 yet
#      if [ "$flofarch" = "386" ]; then
#         tar -xzf include/System/ethereum/386.tar.gz
#         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
#         $maysudo mv go-ipfs/ipfs /usr/bin
#         $maysudo rm -rf go-ipfs
#         chmod +x /usr/bin/ipfs
#         echo "Testing if IPFS works:"
#         ipfs
#fi
if [ "$flofarch" = "amd64" ]; then
   echo "Installing geth..."
   tar -xzf include/System/ethereum/geth-linux-amd64-1.10.11-7231b3ef.tar.gz
   $maysudo mv geth-linux-amd64-*-*/geth /usr/bin
   chmod +x /usr/bin/geth
   rm -rf geth-linux-amd64-1.10.11-7231b3ef
   echo "Testing if geth works:"
   geth -h
fi

echo "----------------------------------------------------------------------"
echo "DEBUG:"
echo "Script path: $SCRIPTPATH"
echo "Current directory: $(pwd)"
echo "ls:"
ls
echo "----------------------------------------------------------------------"

echo "Adding bulbasaur.json..."
$maysudo cp -f include/System/bulbasaur.json /1/bulbasaur.json

#gnome-terminal --tab --title="Installing NodeJS" -- /bin/sh -c 'bash install-node.sh; exec bash'
#(gnome-terminal --tab --title="Installing NodeJS..." -- /bin/sh -c 'bash install-node.sh; exec bash' &)

echo "----------------------------------------------------------------------"
echo "DEBUG:"
echo "Script path: $SCRIPTPATH"
echo "Current directory: $(pwd)"
echo "ls:"
ls
echo "----------------------------------------------------------------------"

# HOME LAYER -->
$maysudo bash include/HTML5Apps/central/install.sh
# <-- HOME LAYER

echo "Installing Hugo (you did great, elder blogspot.com)..."
if [ "$flofarch" = "386" ]; then
   $maysudo dpkg -i include/deb\ packages/hugo/hugo_0.89.2_Linux-32bit.deb
   echo "Testing if Hugo works:"
   hugo -h
fi
if [ "$flofarch" = "amd64" ]; then
   $maysudo dpkg -i include/deb\ packages/hugo/hugo_extended_0.110.0_linux-amd64.deb
   echo "Testing if Hugo works:"
   hugo -h
fi

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

echo "Installing Gnome GAMES (465 kB download; 2,745 kB installed)..."
$maysudo apt install gnome-games-app

echo "Installing nfc-setup (includes NFC Tools)..."
cd include/System/nfc-setup
if [ ! -e .git ]; then git clone --no-checkout https://github.com/danimesq/nfc-setup.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo bash ./install.sh
cd "$SCRIPTPATH"

$maysudo apt install wine64
$maysudo apt install winetricks
$maysudo apt install playonlinux # 62,2 MB of additional disk space will be used
#-
sudo snap install kolourpaint # 10,1 MB disk space

$maysudo apt --fix-broken install
