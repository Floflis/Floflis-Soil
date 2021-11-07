#!/bin/bash

# Layer: Soil

# load definitions & settings
#source /usr/lib/floflis/config # it doesn't works yet. need to do it manually here:
unameOutM="$(uname -m)"
case "${unameOutM}" in
    i286)   flofarch="286";;
    i386)   flofarch="386";;
    i686)   flofarch="386";;
    x86_64) flofarch="amd64";;
    arm)    dpkg --print-flofarch | grep -q "arm64" && flofarch="arm64" || flofarch="arm";;
    riscv64) flofarch="riscv64"
esac

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

$maysudo=""

if [ "$is_root" = "false" ]
   then
      $maysudo="sudo"
   else
      $maysudo=""
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

#echo "- Installing programs..."
#$maysudo apt-get install autoconf elinks ceni gdebi udftools nodejs npm -y && npm i ipfs-npm -g

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
#          $maysudo gdebi include/git-LFS/git-lfs_2.9.2_i386.deb
# fi
#       if [ "$flofarch" = "amd64" ]; then
#          $maysudo gdebi include/git-LFS/git-lfs_2.9.2_amd64.deb
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
#          $maysudo gdebi include/GSM/ppp/ppp_2.4.6-3.1_i386.deb
#          $maysudo gdebi include/GSM/ofono/ofono_1.18-1+b1_i386.deb
#          $maysudo gdebi include/GSM/modemmanager/modemmanager_1.6.4-1_i386.deb
#          $maysudo gdebi include/GSM/wvdial/wvdial_1.61-4.1_i386.deb
# fi
#       if [ "$flofarch" = "amd64" ]; then
#          $maysudo gdebi include/GSM/ppp/ppp_2.4.6-3.1_amd64.deb
#          $maysudo gdebi include/GSM/ofono/ofono_1.18-1+b1_amd64.deb
#          $maysudo gdebi include/GSM/modemmanager/modemmanager_1.6.4-1_amd64.deb
#          $maysudo gdebi include/GSM/wvdial/wvdial_1.61-4.1_amd64.deb
# fi
#       $maysudo gdebi include/GSM/pppconfig/pppconfig_2.3.21_all.deb
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
   . /usr/lib/floflis/./config
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
