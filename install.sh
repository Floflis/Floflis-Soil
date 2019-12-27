#!/bin/bash

# load definitions & settings
source /usr/lib/floflis/config
# it doesn't works yet. need to do it manually here:

unameOutM="$(uname -m)"
case "${unameOutM}" in
    i286)   flofarch="286";;
    i386)   flofarch="386";;
    i686)   flofarch="386";;
    x86_64) flofarch="amd64";;
    arm)    dpkg --print-flofarch | grep -q "arm64" && flofarch="arm64" || flofarch="arm";;
    riscv64) flofarch="riscv64"
esac

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
sudo echo "$(cat /usr/lib/floflis/layers/soil/flo-init)" >> /etc/init.d/flo-init && sudo rm -f /usr/lib/floflis/layers/soil/flo-init
sudo chmod 755 /etc/init.d/flo-init && sudo update-rc.d flo-init defaults

# Install Duniter Server:

   if [ "$flofarch" = "amd64" ]; then
      echo "With Duniter Server, you can create a blockchain for your region and earn UBI (Universal Basic Income)."
      echo "Do you want to install Duniter Server? [Y/n]"
      read instdunserv
      case $instdunserv in
         [nN])
            echo "${ok}"
            break ;;
         [yY])
            echo "Installing Duniter Server..."
            sudo gdebi include/Duniter/duniter-server-v1.7.18-linux-x64.deb
            break ;;
         *)
            echo "${invalid}" ;;
esac
fi

# Install git-LFS:

echo "git-LFS is a need for supporting large file storage in git. Only install it if you're a developer in need of it."
echo "Do you want to install git-LFS? [Y/n]"
read insgit-lfs
case $insgit-lfs in
   [nN])
      echo "${ok}"
      break ;;
   [yY])
      echo "Installing git-LFS..."
            if [ "$flofarch" = "386" ]; then
         sudo gdebi include/git-LFS/git-lfs_2.9.2_i386.deb
fi
      if [ "$flofarch" = "amd64" ]; then
         sudo gdebi include/git-LFS/git-lfs_2.9.2_amd64.deb
fi
      break ;;
   *)
      echo "${invalid}" ;;
esac

echo "- Installing programs..."
sudo apt-get install autoconf elinks ceni gdebi udftools nodejs && npm i ipfs-npm -g

   echo "- Cleanning install, saving settings..."
   sudo rm /usr/lib/floflis/layers/soil/install.sh
   sudo sed -i 's/soil/grass/g' /usr/lib/floflis/config && sudo sed -i 's/core/soil/g' /usr/lib/floflis/config
   echo "(✓) Floflis Core has been upgraded to Floflis Soil."
else
   echo "(X) Floflis Core isn't found. Please install Floflis DNA before installing Floflis Soil."
   echo ""
   echo "Floflis DNA at IPFS:"
   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
