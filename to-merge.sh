#!/bin/bash

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

$maysudo apt install xdotool

ipfs init
#bash ipfsdaemon > ipfs.log &
ipfs daemon
xdotool key Ctrl+d
xdotool key Ctrl+d
# on Cubic, need to have IPFS running on host - until its fixed

$maysudo cat > /usr/share/applications/ipfs-handle-link.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Handler for ipfs:// URIs
Exec=xdg-open %u
StartupNotify=false
MimeType=x-scheme-handler/ipfs;
EOF

$maysudo cat >> /usr/share/applications/x-cinnamon-mimeapps.list <<EOF
x-scheme-handler/ipfs=firefox.desktop;chromium.desktop;
EOF

$maysudo cat > /usr/share/desktop-directories/Finance.directory <<EOF
[Desktop Entry]
Name=Finance
Comment=Financial applications
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=ethereum
Type=Directory
X-Ubuntu-Gettext-Domain=gnome-menus-3.0
EOF

$maysudo mkdir /1/apps
$maysudo ipfs get $(ipfs dns uniswap.eth) --output=/1/apps/uniswap
ipfs add -r /1/apps/uniswap
ipfs pin add $(ipfs dns uniswap.eth)
ipfs ls $(ipfs dns uniswap.eth)
# this will have to work on user side (post-install), not only when installing
$maysudo cat > /usr/bin/uniswap <<EOF
#!/bin/bash

xdg-open ipfs://uniswap.eth
EOF
$maysudo chmod +x /usr/bin/uniswap
$maysudo cat > /usr/share/applications/uniswap.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Uniswap
Comment=Swap/exchange ETH and tokens
Type=Application
Exec=uniswap
Icon=uniswap
Categories=Finance;Ethereum;
Keywords=swap;exchange;tokens;ethereum;
EOF

$maysudo cat > /usr/bin/decentraland <<EOF
#!/bin/bash

xdg-open https://play.decentraland.org/
EOF
$maysudo chmod +x /usr/bin/decentraland
$maysudo cat > /usr/share/applications/decentraland.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Decentraland
Comment=Play in a open 3D metaverse with other etherean players, and spend tokens to buy NFT items/wearables
Type=Application
Exec=decentraland
Icon=decentraland
Categories=Game;Simulation;Metaverse;Ethereum;Polygon;
Keywords=metaverse;world;mining;tokens;ethereum;wearables;multiplayer;roleplaying;
EOF

$maysudo cat > /usr/bin/thesandbox <<EOF
#!/bin/bash

xdg-open https://www.sandbox.game/en/
EOF
$maysudo chmod +x /usr/bin/thesandbox
$maysudo cat > /usr/share/applications/thesandbox.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=The Sandbox
Comment=Play in a open 3D voxels metaverse with other etherean players, and spend tokens to buy NFT items/wearables
Type=Application
Exec=thesandbox
Icon=thesandbox
Categories=Game;Simulation;Metaverse;Ethereum;
Keywords=metaverse;world;mining;tokens;ethereum;wearables;multiplayer;roleplaying;sandbox;voxels;
EOF

$maysudo cat > /usr/bin/cryptovoxels <<EOF
#!/bin/bash

xdg-open https://www.cryptovoxels.com/play
EOF
$maysudo chmod +x /usr/bin/cryptovoxels
$maysudo cat > /usr/share/applications/cryptovoxels.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Cryptovoxels
Comment=Play in a open 3D voxels metaverse with other etherean players, and spend tokens to buy NFT items/wearables
Type=Application
Exec=cryptovoxels
Icon=cryptovoxels
Categories=Game;Simulation;Metaverse;Ethereum;
Keywords=metaverse;world;mining;tokens;ethereum;wearables;multiplayer;roleplaying;sandbox;voxels;
EOF

$maysudo snap install mmex

$maysudo add-apt-repository ppa:openshot.developers/ppa -y && sudo apt-get update -y && sudo apt-get install openshot-qt -y

$maysudo apt install minetest

#- Floflis main Ubuntu ISO will use Ultimate layer. For Home layer, different ISO base: https://help.ubuntu.com/community/Installation/MinimalCD

$maysudo sed -i 's/^PRETTY_NAME=" .*$/PRETTY_NAME=" Floflis 20 build 2106 'Eusoumafoca'"/' /usr/lib/os-release
$maysudo sed -i 's/^DISTRIB_DESCRIPTION=" .*$/DISTRIB_DESCRIPTION=" Floflis 20 build 2106 'Eusoumafoca'"/' /etc/lsb-release

tar -xzf include/icons/Floflis.tar.gz
$maysudo rsync -av Floflis /usr/share/icons
$maysudo rm -rf Floflis
#$maysudo rm -rf /usr/share/icons/Floflis.git

$maysudo mkdir /usr/share/cinnamon
$maysudo mkdir /usr/share/cinnamon/faces
$maysudo mkdir /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/0_cars.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/0_chess.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/0_coffee.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/0_guitar.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/2_10.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/2_11.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/2_12.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/2_13.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/3_lightning.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/3_mountain.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/3_sky.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/3_sunset.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/4_cinnamon.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/4_flower.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/4_leaf.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/4_sunflower.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/5_fish.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/5_kitten.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/5_penguin.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/5_puppy.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/6_astronaut.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/6_butterfly.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/6_flake.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/6_grapes.jpg /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/7_bat.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/7_dog.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/7_elephant.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/7_fox.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/7_lion.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/7_panda.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/7_penguin.png /usr/share/cinnamon/faces/cinnamon
$maysudo mv -f /usr/share/cinnamon/faces/7_tucan.png /usr/share/cinnamon/faces/cinnamon

tar -xzf include/Avatars.tar.gz
$maysudo rsync -av Avatars/. /usr/share/cinnamon/faces
$maysudo rm -rf Avatars

$maysudo mkdir /usr/share/backgrounds/ubuntu
$maysudo mv -f /usr/share/backgrounds/brad-huchteman-stone-mountain.jpg /usr/share/backgrounds/ubuntu
$maysudo mv -f /usr/share/backgrounds/hardy_wallpaper_uhd.png /usr/share/backgrounds/ubuntu
$maysudo mv -f /usr/share/backgrounds/joshua-coleman-something-yellow.jpg /usr/share/backgrounds/ubuntu
$maysudo mv -f /usr/share/backgrounds/matt-mcnulty-nyc-2nd-ave.jpg /usr/share/backgrounds/ubuntu
$maysudo mv -f /usr/share/backgrounds/ryan-stone-skykomish-river.jpg /usr/share/backgrounds/ubuntu
$maysudo mv -f /usr/share/backgrounds/warty-final-ubuntu.png /usr/share/backgrounds/ubuntu

tar -xzf include/Backgrounds.tar.gz
$maysudo rsync -av Backgrounds/. /usr/share/backgrounds
$maysudo rm -rf Backgrounds

$maysudo cp -f include/img/bg.png /usr/share/backgrounds/warty-final-ubuntu.png

$maysudo mkdir /1/sounds
$maysudo cp -f include/sounds/presentation.ogg /1/sounds

$maysudo add-apt-repository ppa:embrosyn/cinnamon
$maysudo apt-get update
$maysudo apt-get install cinnamon
#https://www.edivaldobrito.com.br/instalar-ambiente-cinnamon-3-0-no-ubuntu-16-04/
