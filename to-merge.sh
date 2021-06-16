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
ipfs add $(ipfs dns uniswap.eth)
ipfs pin add $(ipfs dns uniswap.eth)
ipfs get $(ipfs dns uniswap.eth) --output=/1/apps/uniswap
# to change: use a variable. test if ipfs dns result starts with /ipfs/, if not use ethereal ens contenthash get --domain=, and if not display an error
# commands to work on post-install:
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
if [ -e /tmp/cubicmode ]; then
   $maysudo rm -rf /usr/share/icons/Floflis/.git
fi

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

$maysudo mkdir /1/img
$maysudo cp -f include/img/bg.png /1/img/bg.png
$maysudo ln -s /1/img/bg.png /usr/share/backgrounds/warty-final-ubuntu.png

$maysudo mkdir /1/sounds
$maysudo cp -f include/sounds/presentation.ogg /1/sounds/presentation.ogg

$maysudo cp -f include/img/logo.png /1/img/logo.png

$maysudo cp -f include/img/lockscreen.png /1/img/lockscreen.png
$maysudo cp -f include/img/watermark.png /1/img/watermark.png

$maysudo cp -f include/floflis-backgrounds.xml /usr/share/gnome-background-properties/floflis-backgrounds.xml

$maysudo add-apt-repository ppa:embrosyn/cinnamon
$maysudo apt-get update
$maysudo apt-get install cinnamon
#https://www.edivaldobrito.com.br/instalar-ambiente-cinnamon-3-0-no-ubuntu-16-04/

$maysudo apt install gnome-photos
$maysudo apt install gnome-clocks
$maysudo apt install keepassxc
$maysudo apt install gnome-weather

#$maysudo sed -i 's/^Name=" .*$/Name=" Witchcraft"/' /usr/share/applications/org.gnome.Terminal.desktop
$maysudo cat > /usr/share/applications/org.gnome.Terminal.desktop <<EOF
[Desktop Entry]
# VERSION=3.36.2
Name=Witchcraft
Comment=Use the command line
Keywords=shell;prompt;command;commandline;cmd;
TryExec=gnome-terminal
Exec=gnome-terminal
Icon=org.gnome.Terminal
Type=Application
Categories=GNOME;GTK;System;TerminalEmulator;
StartupNotify=true
X-GNOME-SingleWindow=false
OnlyShowIn=GNOME;Unity;
Actions=new-window;preferences;
X-Ubuntu-Gettext-Domain=gnome-terminal

[Desktop Action new-window]
Name=New Window
Exec=gnome-terminal --window

[Desktop Action preferences]
Name=Preferences
Exec=gnome-terminal --preferences
EOF

tar -xzf include/home-daniell-.local-share-cinnamon_usr-share-cinnamon.tar.gz
$maysudo rsync -av cinnamon/. /usr/share/cinnamon
$maysudo rm -rf cinnamon

tar -xzf include/Eleganse-Floflis.tar.gz
$maysudo rsync -av Eleganse-Floflis /usr/share/themes
$maysudo rm -rf Eleganse-Floflis
#$maysudo rm -rf /usr/share/themes/Eleganse-Floflis/.git

tar -xzf include/Adapta.tar.gz
$maysudo rsync -av Adapta /usr/share/themes
$maysudo rm -rf Adapta

tar -xzf include/Adapta-Nokto.tar.gz
$maysudo rsync -av Adapta-Nokto /usr/share/themes
$maysudo rm -rf Adapta-Nokto

#$maysudo sed -i 's/^Name=" .*$/Name=" Cam"/' /usr/share/applications/org.gnome.Cheese.desktop
$maysudo cat > /usr/share/applications/org.gnome.Cheese.desktop <<EOF
[Desktop Entry]
Name=Cam
GenericName=Webcam Booth
Comment=Take photos and videos with your webcam, with fun graphical effects
# Translators: Search terms to find this application. Do NOT translate or localize the semicolons! The list MUST also end with a semicolon!
Keywords=photo;video;webcam;
Exec=cheese
Terminal=false
Type=Application
StartupNotify=true
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=org.gnome.Cheese
Categories=GNOME;AudioVideo;Video;Recorder;
DBusActivatable=true
X-Ubuntu-Gettext-Domain=cheese
EOF

#$maysudo sed -i 's/^Name=" .*$/Name=" Music"/' /usr/share/applications/rhythmbox.desktop
$maysudo cat > /usr/share/applications/rhythmbox.desktop <<EOF
[Desktop Entry]
Name=Music
GenericName=Music Player
X-GNOME-FullName=Rhythmbox Music Player
Comment=Play and organize your music collection
Keywords=Audio;Song;MP3;CD;Podcast;MTP;iPod;Playlist;Last.fm;UPnP;DLNA;Radio;
Exec=rhythmbox %U
Terminal=false
Type=Application
Icon=org.gnome.Rhythmbox
X-GNOME-DocPath=rhythmbox/rhythmbox.xml
Categories=GNOME;GTK;AudioVideo;Audio;Player;
MimeType=application/x-ogg;application/ogg;audio/x-vorbis+ogg;audio/vorbis;audio/x-vorbis;audio/x-scpls;audio/x-mp3;audio/x-mpeg;audio/mpeg;audio/x-mpegurl;audio/x-flac;audio/mp4;audio/x-it;audio/x-mod;audio/x-s3m;audio/x-stm;audio/x-xm;
StartupNotify=true
X-GNOME-Bugzilla-Bugzilla=GNOME
X-GNOME-Bugzilla-Product=rhythmbox
X-GNOME-Bugzilla-Component=general
X-GNOME-Bugzilla-OtherBinaries=rhythmbox-client;rhythmbox-metadata;
X-GNOME-Bugzilla-Version=3.4.4
X-GNOME-UsesNotifications=true
Actions=PlayPause;Next;Previous;StopQuit;
X-Ubuntu-Gettext-Domain=rhythmbox

[Desktop Action PlayPause]
Name=Play/Pause
Exec=rhythmbox-client --play-pause

[Desktop Action Next]
Name=Next
Exec=rhythmbox-client --next

[Desktop Action Previous]
Name=Previous
Exec=rhythmbox-client --previous

[Desktop Action StopQuit]
Name=Stop & Quit
Exec=rhythmbox-client --quit
EOF

$maysudo rm -f /usr/share/sounds/Yaru/stereo/system-ready.oga && $maysudo ln -s /usr/share/sounds/Yaru/stereo/desktop-login.oga /usr/share/sounds/Yaru/stereo/system-ready.oga

# Base sounds
$maysudo cp -f include/sounds/Base/Changing\ volume.ogg /1/sounds/Changing\ volume.ogg
$maysudo cp -f include/sounds/Base/Inserting\ device.ogg /1/sounds/Inserting\ device.ogg
$maysudo cp -f include/sounds/Base/Leaving.ogg /1/sounds/Leaving.ogg
$maysudo cp -f include/sounds/Base/Manipulating\ windows.ogg /1/sounds/Manipulating\ windows.ogg
$maysudo cp -f include/sounds/Base/Notification.ogg /1/sounds/Notification.ogg
$maysudo cp -f include/sounds/Base/Removing\ device.ogg /1/sounds/Removing\ device.ogg
$maysudo cp -f include/sounds/Base/Starting.ogg /1/sounds/Starting.ogg
$maysudo cp -f include/sounds/Base/Switching\ workspace.ogg /1/sounds/Switching\ workspace.ogg

$maysudo mkdir /usr/share/sounds/Yaru/stereo/ubuntu
$maysudo mv -f /usr/share/sounds/Yaru/stereo/desktop-login.oga /usr/share/sounds/Yaru/stereo/ubuntu
$maysudo mv -f /usr/share/sounds/Yaru/stereo/system-ready.oga /usr/share/sounds/Yaru/stereo/ubuntu
$maysudo ln -s /1/sounds/Starting.ogg /usr/share/sounds/Yaru/stereo/desktop-login.oga
$maysudo ln -s /1/sounds/Starting.ogg /usr/share/sounds/Yaru/stereo/system-ready.oga

# Home sounds patch
$maysudo cp -f include/sounds/Base/Home/Dialog.ogg /1/sounds/Dialog.ogg
$maysudo cp -f include/sounds/Base/Home/Navigation.ogg /1/sounds/Navigation.ogg
$maysudo cp -f include/sounds/Base/Home/Notification.ogg /1/sounds/Notification.ogg
$maysudo cp -f include/sounds/Base/Home/Notification\ Important.flac /1/sounds/Notification\ Important.flac
$maysudo cp -f include/sounds/Base/Home/System\ Logon.oga /1/sounds/System\ Logon.oga
$maysudo rm -f /1/sounds/Starting.ogg && $maysudo ln -s /1/sounds/System\ Logon.oga /1/sounds/Starting.ogg

if [ -e /usr/share/ubiquity-slideshow ]; then
    $maysudo mkdir /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/screenshots/welcome.png /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/screenshots/photos.png /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu

    $maysudo mkdir /usr/share/ubiquity-slideshow/slides/icons/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/icons/firefox.png /usr/share/ubiquity-slideshow/slides/icons/ubuntu

    $maysudo mkdir /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/welcome.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/music.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/accessibility.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/browse.html /usr/share/ubiquity-slideshow/slides/ubuntu

    $maysudo mkdir /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/background.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/bullet-point.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/arrow-back.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/arrow-next.png /usr/share/ubiquity-slideshow/slides/link/ubuntu

    tar -xzf include/ubiquity-slideshow.tar.gz
    $maysudo rsync -av ubiquity-slideshow /usr/share
    $maysudo rm -rf ubiquity-slideshow
    #$maysudo rm -rf /usr/share/ubiquity-slideshow/.git
fi

if [ ! -e /usr/share/icons/Yaru ]; then
   tar -xzf include/icons/Yaru.tar.gz
   $maysudo rsync -av Yaru /usr/share/icons
   $maysudo rm -rf Yaru
fi

if [ -e /usr/share/icons/Yaru ]; then
       echo "Proceeding with the install of Floflis icons..." #futurely, Floflis icons will be an separate package with its own installer
       $maysudo mkdir /usr/share/icons/ubuntu
       $maysudo mv -f /usr/share/icons/Yaru /usr/share/icons/ubuntu/Yaru
       $maysudo ln -s /usr/share/icons/Floflis /usr/share/icons/Yaru
       # echo "de-duplicing icons in hicolor..." sudo rm -f cinnamon-preferences-color.png && sudo rm -f csd-color.png && sudo ln -s preferences-color.png cinnamon-preferences-color.png && sudo ln -s preferences-color.png csd-color.png
       echo "de-duplicing some icons in Yaru..."
       echo "de-duplicing some icons in Yaru/apps..."
       cd /usr/share/icons/ubuntu/Yaru/apps
       rm -f org.gnome.baobab.png && ln -s disk-usage-app.png baobab.png && ln -s disk-usage-app.png org.gnome.baobab.png && rm -f bijiben.png && rm -f org.gnome.bijiben.png && rm -f org.gnome.Bijiben.png && rm -f org.gnome.Notes.png && ln -s notes-app.png bijiben.png && ln -s notes-app.png org.gnome.bijiben.png && ln -s notes-app.png org.gnome.Bijiben.png && ln -s notes-app.png org.gnome.Notes.png && rm -f dconf-editor.png && rm -f ca.desrt.dconf-editor.png && ln -s configurator-app.png dconf-editor.png && ln -s configurator-app.png ca.desrt.dconf-editor.png && rm -f gnome-clocks.png && rm -f org.gnome.clocks.png && rm -f org.gnome.Clocks.png && ln -s clock-app.png gnome-clocks.png && ln -s clock-app.png org.gnome.clocks.png && ln -s clock-app.png org.gnome.Clocks.png && rm -f gnome-disks.png && rm -f org.gnome.Disks.png && rm -f org.gnome.DiskUtility.png && ln -s disk-utility-app.png gnome-disks.png && ln -s disk-utility-app.png org.gnome.Disks.png && ln -s disk-utility-app.png org.gnome.DiskUtility.png && rm -f gnome-documents.png && rm -f org.gnome.Documents.png && ln -s documents-app.png gnome-documents.png && ln -s documents-app.png org.gnome.Documents.png && rm -f org.gnome.Books.png && ln -s ebook-reader-app.png org.gnome.Books.png && rm -f empathy.png && rm -f internet-chat.png && rm -f org.gnome.Empathy.png && ln -s messaging-app.png empathy.png && ln -s messaging-app.png internet-chat.png && ln -s messaging-app.png org.gnome.Empathy.png && rm -f eog.png && rm -f multimedia-photo-viewer.png && rm -f org.gnome.eog.png && ln -s image-viewer-app.png eog.png && ln -s image-viewer-app.png multimedia-photo-viewer.png && ln -s image-viewer-app.png org.gnome.eog.png && rm -f org.gnome.Evince.png && ln -s evince.png org.gnome.Evince.png
       rm -f gnome-screenshot.png && rm -f org.gnome.Screenshot.png && rm -f screenshot-app.png && ln -s applets-screenshooter.png gnome-screenshot.png && ln -s applets-screenshooter.png org.gnome.Screenshot.png && ln -s applets-screenshooter.png screenshot-app.png && rm -f gnome-characters.png && rm -f org.gnome.Characters.png && ln -s accessories-character-map.png gnome-characters.png && ln -s accessories-character-map.png org.gnome.Characters.png && rm -f gedit.png && rm -f org.gnome.gedit.png && rm -f org.gnome.Gedit.png && ln -s accessories-text-editor.png gedit.png && ln -s accessories-text-editor.png org.gnome.gedit.png && ln -s accessories-text-editor.png org.gnome.Gedit.png && rm -f gnome-contacts.png && rm -f office-address-book.png && rm -f office-addressbook.png && rm -f org.gnome.Contacts.png && rm -f x-office-address-book.png && ln -s address-book-app.png gnome-contacts.png && ln -s address-book-app.png office-address-book.png && ln -s address-book-app.png office-addressbook.png && ln -s address-book-app.png org.gnome.Contacts.png && ln -s address-book-app.png x-office-address-book.png && rm -f apport.png && ln -s error-app.png apport.png && rm -f packages-app.png && ln -s system-software-install.png packages-app.png && rm -f deja-dup.png && rm -f org.gnome.DejaDup.png && ln -s backups-app.png deja-dup.png && ln -s backups-app.png org.gnome.DejaDup.png && rm -f baobab.png
fi

#ipfs add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs pin add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs get $(ethereal ens contenthash get --domain=1inch.eth) --output=/1/apps/1inch
# commands to work on post-install:
#ipfs add -r /1/apps/1inch
#ipfs pin add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs ls $(ethereal ens contenthash get --domain=1inch.eth)
# this will have to work on user side (post-install), not only when installing
#$maysudo cat > /usr/bin/1inch <<EOF
#!/bin/bash
#
#xdg-open ipfs://1inch.eth
#EOF
#$maysudo chmod +x /usr/bin/1inch
#$maysudo cat > /usr/share/applications/1inch.desktop <<EOF
#[Desktop Entry]
#Encoding=UTF-8
#Name=1inch
#Comment=Swap ETH and tokens on multiple exchanges
#Type=Application
#Exec=1inch
#Icon=1inch
#Categories=Finance;Ethereum;
#Keywords=swap;exchange;tokens;ethereum;
#EOF

 Install git-LFS:

 echo "git-LFS is a need for supporting large file storage in git. Only install it if you're a developer in need of it."
 echo "Do you want to install git-LFS? [Y/n]"
 read insgitlfs
 case $insgitlfs in
    [nN])
       echo "${ok}"
       break ;;
    [yY])
       echo "Installing git-LFS..."
             if [ "$flofarch" = "386" ]; then
          $maysudo gdebi include/git-LFS/git-lfs_2.9.2_i386.deb
 fi
       if [ "$flofarch" = "amd64" ]; then
          $maysudo gdebi include/git-LFS/git-lfs_2.9.2_amd64.deb
 fi
       break ;;
    *)
       echo "${invalid}" ;;
 esac
