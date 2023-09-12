#!/bin/bash

# Layer: Soil

# load definitions & settings
. /usr/lib/floflis/./config

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

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

if [ -e /tmp/cubicmode ]; then
maysudo=""
fi

cat << "EOF"
-. .-.   .-. .-.   .-. .-.   .
  \   \ /   \   \ /   \   \ /
 / \   \   / \   \   / \   \
~   `-~ `-`   `-~ `-`   `-~ `-
  _            _           
 |_  |   _   _|_  |  o   _ 
 |   |  (_)   |   |  |  _> 
                           
  ___               _            _   _             
 |_ _|  _ _    ___ | |_   __ _  | | | |  ___   _ _ 
  | |  | ' \  (_-< |  _| / _` | | | | | / -_) | '_|
 |___| |_||_| /__/  \__| \__,_| |_| |_| \___| |_|  

                  for Floflis Soil
EOF
echo "- Detecting if Floflis Core is installed..."
if [ -e /usr/lib/floflis/layers/core ]
then
echo "- Installing Floflis Soil as init program..."
$maysudo echo "$(cat /usr/lib/floflis/layers/soil/flo-init)" >> /etc/init.d/flo-init && $maysudo rm -f /usr/lib/floflis/layers/soil/flo-init
$maysudo chmod 755 /etc/init.d/flo-init && $maysudo update-rc.d flo-init defaults

echo "- Installing programs..."
#$maysudo apt-get install autoconf elinks ceni gdebi udftools
$maysudo apt-get install nodejs npm -y #&& npm i ipfs-npm -g

echo "Installing neofetch..."
if [ ! -e /usr/lib/neofetch ]; then $maysudo mkdir /usr/lib/neofetch; fi
cd include/Terminal/neofetch
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/neofetch.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo cp -r -f --preserve=all . /usr/lib/neofetch
$maysudo mv -f /usr/lib/neofetch/neofetch /usr/bin/neofetch
$maysudo chmod +x /usr/bin/neofetch
#rm -rf .github #use noah to exclude everything except .git
#rm -f CONTRIBUTING.md
#rm -f LICENSE.md
#rm -f Makefile
#rm -f neofetch
#rm -f neofetch.1
#rm -f README.md
#rm -f .travis.yml
cd "$SCRIPTPATH"
echo "Testing if neofetch works:"
neofetch

# Install git-LFS:

# echo "git-LFS is a need for supporting large file storage in git. Only install it if you're a developer in need of it."
# echo "Do you want to install git-LFS? [Y/n]"
# read insgitlfs
# case $insgitlfs in
#    [nN])
#       echo "${ok}"
#       break ;;
#    [yY])
#       echo "Installing git-LFS..."
#             if [ "$flofarch" = "386" ]; then
#          $maysudo gdebi include/git-LFS/git-lfs_2.9.2_i386.deb --refuse-downgrade
# fi
#       if [ "$flofarch" = "amd64" ]; then
#          $maysudo gdebi include/git-LFS/git-lfs_2.9.2_amd64.deb --refuse-downgrade
# fi
#       break ;;
#    *)
#       echo "${invalid}" ;;
# esac

# Install GSM:

# echo "Do you want to install support for GSM calls and 2G/3G/4G modems? [Y/n]"
# read instgsm
# case $instgsm in
#    [nN])
#       echo "${ok}"
#       break ;;
#    [yY])
#       echo "Installing GSM support..."
#             if [ "$flofarch" = "386" ]; then
#          $maysudo gdebi include/GSM/ppp/ppp_2.4.6-3.1_i386.deb --refuse-downgrade
#          $maysudo gdebi include/GSM/ofono/ofono_1.18-1+b1_i386.deb --refuse-downgrade
#          $maysudo gdebi include/GSM/modemmanager/modemmanager_1.6.4-1_i386.deb --refuse-downgrade
#          $maysudo gdebi include/GSM/wvdial/wvdial_1.61-4.1_i386.deb --refuse-downgrade
# fi
#       if [ "$flofarch" = "amd64" ]; then
#          $maysudo gdebi include/GSM/ppp/ppp_2.4.6-3.1_amd64.deb --refuse-downgrade
#          $maysudo gdebi include/GSM/ofono/ofono_1.18-1+b1_amd64.deb --refuse-downgrade
#          $maysudo gdebi include/GSM/modemmanager/modemmanager_1.6.4-1_amd64.deb --refuse-downgrade
#          $maysudo gdebi include/GSM/wvdial/wvdial_1.61-4.1_amd64.deb --refuse-downgrade
# fi
#       $maysudo gdebi include/GSM/pppconfig/pppconfig_2.3.21_all.deb --refuse-downgrade
#       break ;;
#    *)
#       echo "${invalid}" ;;
# esac

#- if ubuntu, use sudo dpkg -i 

   if [ -e /tmp/cubicmode ]; then
      echo "Detected Cubic mode 🧚"
      echo "Installing to-merge.sh..."
      $maysudo bash ./to-merge.sh
      echo "Done (to-merge.sh)"
fi

   echo "- Installing Floflis Fixer..."
   $maysudo mv /usr/lib/floflis/layers/soil/fixer /usr/bin
   $maysudo chmod 755 /usr/bin/fixer

   echo "- Cleanning install, saving settings..."
   $maysudo rm /usr/lib/floflis/layers/soil/install.sh
   $maysudo sed -i 's/soil/grass/g' /usr/lib/floflis/config && $maysudo sed -i 's/core/soil/g' /usr/lib/floflis/config
#   . /usr/lib/floflis/./config #moved to top
   contents="$(jq ".layer = \"$layer\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   contents="$(jq ".nxtlayer = \"$nxtlayer\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   echo "(✓) Floflis Core has been upgraded to Floflis Soil."
else
   echo "(X) Floflis Core isn't found. Please install Floflis DNA before installing Floflis Soil."
   echo ""
   echo "Floflis DNA at IPFS:"
   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
