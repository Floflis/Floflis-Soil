#!/bin/bash

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
cd "$SCRIPTPATH"
#cd ${D}

echo "Installing Templates of the 'New File' context menu..."
rsync -av /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-Templates/. /home/${flouser}/Templates
rm /home/${flouser}/Templates/New\ slidesPresentation.pptx.webpresent
rm /home/${flouser}/Templates/New\ Spreadsheet.xlsx.webpresent
rm /home/${flouser}/Templates/New\ WordWriter\ document.docx.webpresent
rm /home/${flouser}/Templates/New\ Access\ Database.accdb.webpresent
rm /home/${flouser}/Templates/"New Compressed (zipped) Folder.zip.webpresent"
rm /home/${flouser}/Templates/New\ Publisher\ Document.pub.webpresent

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
#cd ${D}
cd "$SCRIPTPATH"

echo "Installing floapps..."
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/floapps
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/floapps.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
#$maysudo bash install.sh
#chmod +x install.sh && $maysudo sh ./install.sh
chmod +x install.sh && $maysudo bash install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -rf include
cd "$SCRIPTPATH"

#echo "Adding Starship to nushell..."
#if [ ! -e /home/${flouser}/.config/nu ]; then mkdir /home/${flouser}/.config/nu; fi
#cat >> /home/${flouser}/.config/nu/config.toml <<EOF
#startup = [
# "mkdir ~/.cache/starship",
# "starship init nu | save ~/.cache/starship/init.nu",
# "source ~/.cache/starship/init.nu"
#]
#prompt = "starship_prompt"
#EOF

cd /home/${flouser} && ln -sf .config/nushell/history.txt .nu_history

facevar="/home/${flouser}/.face"
if [ ! -f "$facevar" ]; then
#   ln -s /usr/share/cinnamon/faces/user-generic.png "$facevar"
   cp /usr/share/cinnamon/faces/user-generic.png "$facevar"
fi

echo "Installing Sample Media..."
if [ ! -e /home/${flouser}/Pictures/Sample\ Photos ]; then mkdir /home/${flouser}/Pictures/Sample\ Photos; fi
if [ ! -e /home/${flouser}/Videos/Sample\ Videos ]; then mkdir /home/${flouser}/Videos/Sample\ Videos; fi
if [ ! -e /home/${flouser}/Music/Sample\ Music ]; then mkdir /home/${flouser}/Music/Sample\ Music; fi
cp '/usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Home/Pictures/Sample Photos/Phabulous Pabllo Vittar 💞.jpeg' /home/${flouser}/Pictures/Sample\ Photos/
cp '/usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Home/Videos/Sample Videos/Home Life - Animals.3gp' /home/${flouser}/Videos/Sample\ Videos/

# HOME LAYER -->
# Install IPFS-Desktop:
if [ "$flofarch" = "amd64" ]; then
   echo "Installing IPFS Desktop..."
   $maysudo snap install ipfs-desktop
   rm -f '/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs/ipfs' && sudo ln -sf /usr/bin/ipfs '/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs'
   $maysudo cat >> /usr/bin/ipfsdaemon << ENDOFFILE
ipfs-desktop
ENDOFFILE
   $maysudo chmod +x /usr/bin/ipfsdaemon
fi
# <-- HOME LAYER

# Install 1inch + Cowswap, but this feature will be region-locked and need an Internet connection before pinning ----------------------------------------------------->
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
#ipfs-desktop
#xdg-open ipns://1inch.eth
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
# <----------------------------------------------------- Prepare to replace 1inch to better alternative (should also support GnosisChain)

echo "Installing Hop protocol..."
cp /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/hop.svg /usr/share/icons/hicolor/scalable/apps/
$maysudo gtk-update-icon-cache /usr/share/icons/gnome/ -f
tar -xzf /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/hop.tar.gz
mv -f hop /1/apps
if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
#ipfs add $(ipfs dns hop.mirroring.eth)
#ipfs pin add $(ipfs dns hop.mirroring.eth)
ipfs pin add $(ethereal ens contenthash get --domain=hop.mirroring.eth)
#ipfs get $(ipfs dns hop.mirroring.eth) --output=/1/apps/hop
ipfs get $(ethereal ens contenthash get --domain=hop.mirroring.eth) --output=/1/apps/hop
# to change: use a variable. test if ipfs dns result starts with /ipfs/, if not use ethereal ens contenthash get --domain=, and if not display an error
# commands to work on post-install:
#ipfs add -r /1/apps/hop
#ipfs dns hop.mirroring.eth && ipfs dns hop.mirroring.eth
#ipfs pin add $(ipfs dns hop.mirroring.eth)
#ipfs ls $(ipfs dns hop.mirroring.eth)
#ipfs pin add $(ipfs dns hop.mirroring.eth)
#- this will have to work on user side (post-install), not only when installing
fi
$maysudo cat > /usr/bin/hop <<EOF
#!/bin/bash

#xdg-open https://app.hop.exchange/ #removed
#xdg-open ipns://hop.exchange #not ENS
xdg-open ipns://hop.mirroring.eth
EOF
$maysudo chmod +x /usr/bin/hop
$maysudo cat > /usr/share/applications/hop.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Hop protocol
Comment=Send ETH and tokens from Ethereum to Layer2's and vice-versa!
Type=Application
Exec=hop
Icon=hop
Categories=Finance;Ethereum;
Keywords=bridge;swap;exchange;tokens;ethereum;xdai;polygon;bsc;binance-smart-chain;arbitrum;optimism
EOF

echo "Installing Aragon..."
cp /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/aragon.svg /usr/share/icons/hicolor/scalable/apps/
$maysudo gtk-update-icon-cache /usr/share/icons/gnome/ -f
tar -xzf /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/aragon.tar.gz
mv -f aragon /1/apps
if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
#ipfs add $(ipfs dns aragon.plasmmer.eth)
#ipfs pin add $(ipfs dns aragon.plasmmer.eth)
ipfs pin add $(ethereal ens contenthash get --domain=aragon.plasmmer.eth)
#ipfs get $(ipfs dns aragon.plasmmer.eth) --output=/1/apps/aragon
ipfs get $(ethereal ens contenthash get --domain=aragon.plasmmer.eth) --output=/1/apps/aragon
# to change: use a variable. test if ipfs dns result starts with /ipfs/, if not use ethereal ens contenthash get --domain=, and if not display an error
# commands to work on post-install:
#ipfs add -r /1/apps/aragon
#ipfs dns aragon.plasmmer.eth && ipfs dns aragon.plasmmer.eth
#ipfs pin add $(ipfs dns aragon.plasmmer.eth)
#ipfs ls $(ipfs dns aragon.plasmmer.eth)
#ipfs pin add $(ipfs dns aragon.plasmmer.eth)
#- this will have to work on user side (post-install), not only when installing
fi
$maysudo cat > /usr/bin/aragon <<EOF
#!/bin/bash

ipfsdaemon
#xdg-open ipns://aragon.plasmmer.eth
xdg-open https://aragon.plasmmer.com #until IPFS issue is fixed
EOF
$maysudo chmod +x /usr/bin/aragon
$maysudo cat > /usr/share/applications/aragon.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Aragon
Comment=Participate on Internet-native organizations/enterprises (as BTC/ETH are the Internet-native money) or create your own!
Type=Application
Exec=aragon
Icon=aragon
Categories=Office;Finance;Ethereum;
Keywords=daos;govern;governance;organizations;decentralized;autonomous;tokens;ethereum;xdai;polygon
EOF
if [ ! -e /1/img/humanrepresentation ]; then $maysudo mkdir /1/img/humanrepresentation; fi
$maysudo ln -s /1/apps/aragon/action-create.ee78fef6.png /1/img/humanrepresentation/action-create.png
$maysudo ln -s /1/apps/aragon/activity-no-results.51fb2b93.png /1/img/humanrepresentation/look-at-phone.png

sudo chmod -R a+rwX /home/${flouser}/.config/nushell && sudo chown -R ${flouser}:${flouser} /home/${flouser}/.config/nushell

echo "Installing ethgas..."
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Tools/ethgas
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/ethgas.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f ethgas
#rm -f gas-pump.svg
#rm -f gas-pump-symbolic.svg
#rm -f .gitmeta
#rm -f 'SRC At ETH💎💌.txt'
echo "Installing ethgas' Cinnamon spice..."
cd spice
#cd ethgas-applet@floflis
#zombiespices install
#cd ..
cd ethgas-desklet@floflis
zombiespices install
cd "$SCRIPTPATH"

echo "Installing Firedoge browser..."
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/System/firedoge
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Web3HQ/firedoge.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && bash install.sh
cd "$SCRIPTPATH"

echo "Do you want to install the MS Edge browser? [Y/n]"
   read setedge
   case $setedge in
      [nN])
         echo "Ok, not going to install MS Edge for now; anyway it should be available in Floflis' stores."
         ;;
      [yY])
         echo "Important:" && echo ""
         cat /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/DEB/TERMS && echo ""
         echo "Privacy statement: https://go.microsoft.com/fwlink/?LinkId=521839" && echo ""
         echo "Installing Microsoft Edge will add the Microsoft repository so your system will automatically keep Microsoft Edge up to date." && echo ""
         echo "Scroll up to read. PLEASE READ/WRITE CAREFULLY!"
         echo "Do you agree with the terms? [Y/n]"
            read licenseagreement
            case $licenseagreement in
               [nN])
                  exit ;;
               [yY])
                  echo "Installing MS Edge..."
                  $maysudo dpkg -i /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/DEB/microsoft-edge-stable_110.0.1587.57-1_amd64.deb
            esac
esac

echo "Do you want to install the \"WindOS\"🪟 Calculator? [Y/n]"
echo "Please note Floflis do already include a basic calculator by default."
   read setunocalc
   case $setunocalc in
      [nN])
         echo "Ok, not going to install WinCalculator for now; anyway it should be available in Floflis' stores."
         ;;
      [yY])
         sudo snap install uno-calculator
esac
#if user is an IT technician installing for a customer, don't ask and install MS Edge and Calculator right away)
#floflis fixer should support reinstalling default calculator

echo "Setting autostart apps..."
chmod +x /home/${flouser}/.config/autostart/teams.desktop

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="How you prefer your mouse cursor color?"

OPTIONS=(1 "⚫Black (like in \"MecOS\"🍎)"
         2 "⚪White (like in \"WindOS\"🪟)")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            gsettings set org.cinnamon.desktop.interface cursor-theme 'DMZ-White' #from https://askubuntu.com/a/72093
            ;;
        2)
            gsettings set org.cinnamon.desktop.interface cursor-theme 'Floflis' #from https://askubuntu.com/a/72093
            ;;
esac
#from https://askubuntu.com/a/666179
#in UI, will have different background as example

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="How you prefer your system theme?"

OPTIONS=(1 "⚫Dark (let's save my eyes while computing in the dark)"
         2 "🟤Normal (i have strong eyes)"
         3 "⚪Light (i have stronger eyes, still; let's not abuse)")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis-dark' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis-dark' && gsettings set org.cinnamon.theme name 'Yaru-floflis-dark' #from https://askubuntu.com/a/72093
            ;;
        2)
            gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis' && gsettings set org.cinnamon.theme name 'Yaru-floflis' #from https://askubuntu.com/a/72093
            ;;
        3)
            gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis-light' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis-light' && gsettings set org.cinnamon.theme name 'Yaru-floflis-light' #from https://askubuntu.com/a/72093
            ;;
esac
#from https://askubuntu.com/a/666179
#in UI, will have different background as example

if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
echo "Preparing to create your ETH address..."
bash /usr/lib/floflis/layers/soil/to-merge/ethgenerate.sh
fi

$maysudo rm -rf /usr/lib/floflis/layers/soil/to-merge/include-firstlogon
