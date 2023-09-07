#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Installing the \"Starshell\" package..."
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Terminal/starshell
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/starshell.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f README.md
#rm -f shit
#rm -f .gitmeta
#cd ${D}
cd "$SCRIPTPATH"
#-
sudo chmod -R a+rwX /home/${flouser}/.config/nushell && sudo chown -R ${flouser}:${flouser} /home/${flouser}/.config/nushell
#-
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/login-shell false
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-custom-command true
#-
cd /home/${flouser} && ln -sf .config/nushell/history.txt .nu_history
#-
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

echo "Installing Templates of the 'New File' context menu..."
rsync -av /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-Templates/. /home/${flouser}/Templates
rm /home/${flouser}/Templates/New\ slidesPresentation.pptx.webpresent
rm /home/${flouser}/Templates/New\ Spreadsheet.xlsx.webpresent
rm /home/${flouser}/Templates/New\ WordWriter\ document.docx.webpresent
rm /home/${flouser}/Templates/New\ Access\ Database.accdb.webpresent
rm /home/${flouser}/Templates/"New Compressed (zipped) Folder.zip.webpresent"
rm /home/${flouser}/Templates/New\ Publisher\ Document.pub.webpresent

echo "Installing Sample Media..."
if [ ! -e /home/${flouser}/Pictures/Sample\ Photos ]; then mkdir /home/${flouser}/Pictures/Sample\ Photos; fi
if [ ! -e /home/${flouser}/Videos/Sample\ Videos ]; then mkdir /home/${flouser}/Videos/Sample\ Videos; fi
if [ ! -e /home/${flouser}/Music/Sample\ Music ]; then mkdir /home/${flouser}/Music/Sample\ Music; fi
cp '/usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Home/Pictures/Sample Photos/Phabulous Pabllo Vittar 💞.jpeg' /home/${flouser}/Pictures/Sample\ Photos/
cp '/usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Home/Videos/Sample Videos/Home Life - Animals.3gp' /home/${flouser}/Videos/Sample\ Videos/

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

facevar="/home/${flouser}/.face"
if [ ! -f "$facevar" ]; then
#   ln -s /usr/share/cinnamon/faces/user-generic.png "$facevar"
   cp /usr/share/cinnamon/faces/user-generic.png "$facevar"
fi

echo "Installing floapps..."
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/floapps
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/floapps.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
#sudo bash install.sh
#chmod +x install.sh && sudo sh ./install.sh
chmod +x install.sh && bash install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -rf include
cd "$SCRIPTPATH"

cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Tools
#-
cd neurus-core
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/neurus-core.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
echo "Installing neurus-core..."
chmod +x install.sh && sudo sh ./install.sh
cd "$SCRIPTPATH"

# HOME LAYER -->
# Install IPFS-Desktop:
if [ "$flofarch" = "amd64" ]; then
   echo "Installing IPFS Desktop..."
   sudo snap install ipfs-desktop
   rm -f '/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs/ipfs' && sudo ln -sf /usr/bin/ipfs '/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs'
   sudo cat >> /usr/bin/ipfsdaemon << ENDOFFILE
ipfs-desktop
ENDOFFILE
   sudo chmod +x /usr/bin/ipfsdaemon
fi
# <-- HOME LAYER

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
                  sudo dpkg -i /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/DEB/microsoft-edge-stable_110.0.1587.57-1_amd64.deb
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

echo "Installing support for Windows apps..."
sudo apt install -y software-properties-common
sudo wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key && rm winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ lunar main'
sudo apt update
sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y install --install-recommends winehq-stable
sudo apt install wine32:i386 # 1GB+!
sudo apt install wine32
sudo apt install wine64 -y # nearly 2GB!
sudo apt install winetricks -y
wget https://dl.winehq.org/wine/wine-mono/8.0.0/wine-mono-8.0.0-x86.msi && wine msiexec /i wine-mono-8.0.0-x86.msi #from https://askubuntu.com/a/1448770 (have to login and VOTE)
if [ -f wine-mono-8.0.0-x86.msi ]; then rm wine-mono-8.0.0-x86.msi; fi
winetricks dotnet45 #from https://askubuntu.com/a/1106750 (have to login and VOTE)
sudo apt install playonlinux -y # 62,2 MB of additional disk space will be used
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/System/wine-desktop-common
if [ ! -e .git ]; then git clone --no-checkout https://github.com/bobwya/wine-desktop-common.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
sudo make install
cd "$SCRIPTPATH"
# WinApps
echo "Installing WinApps..."
sudo apt-get install -y virt-manager #Need to get 10,1 MB of archives. After this operation, 44,4 MB of additional disk space will be used.
echo "Have already installed KVM/virt-manager. Pending to follow the next steps: https://github.com/Fmstrat/winapps/blob/main/docs/KVM.md"
sudo apt-get install -y freerdp2-x11
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/System/winapps
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Fmstrat/winapps.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
#sudo bash install.sh
if [ ! -e /usr/lib/winapps ]; then sudo mkdir /usr/lib/winapps; fi
sudo rsync -av . /usr/lib/winapps
sudo rm -f /usr/lib/winapps/icons/windows.svg
cat > /usr/bin/winapps << ENDOFFILE
#!/bin/bash

source /usr/lib/winapps/bin/winapps
ENDOFFILE
cd "$SCRIPTPATH"

echo "Installing ethgas..."
cd /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Tools/ethgas
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/ethgas.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sudo sh ./install.sh
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

# Install 1inch + Cowswap, but this feature will be region-locked and need an Internet connection before pinning ----------------------------------------------------->
#ipfs add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs pin add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs get $(ethereal ens contenthash get --domain=1inch.eth) --output=/1/apps/1inch
# commands to work on post-install:
#ipfs add -r /1/apps/1inch
#ipfs pin add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs ls $(ethereal ens contenthash get --domain=1inch.eth)
# this will have to work on user side (post-install), not only when installing
#sudo cat > /usr/bin/1inch <<EOF
#!/bin/bash
#
#ipfs-desktop
#xdg-open ipns://1inch.eth
#EOF
#sudo chmod +x /usr/bin/1inch
#sudo cat > /usr/share/applications/1inch.desktop <<EOF
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
sudo gtk-update-icon-cache /usr/share/icons/gnome/ -f
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
sudo cat > /usr/bin/hop <<EOF
#!/bin/bash

#xdg-open https://app.hop.exchange/ #removed
#xdg-open ipns://hop.exchange #not ENS
xdg-open ipns://hop.mirroring.eth
EOF
sudo chmod +x /usr/bin/hop
sudo cat > /usr/share/applications/hop.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Hop protocol
Comment=Send ETH and tokens from Ethereum to Layer2's and vice-versa!
Type=Application
Exec=hop
Icon=hop
Categories=Blockchain;Finance;Ethereum;
Keywords=bridge;swap;exchange;tokens;ethereum;xdai;polygon;bsc;binance-smart-chain;arbitrum;optimism
EOF

echo "Installing Aragon..."
cp /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/aragon.svg /usr/share/icons/hicolor/scalable/apps/
sudo gtk-update-icon-cache /usr/share/icons/gnome/ -f
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
sudo cat > /usr/bin/aragon <<EOF
#!/bin/bash

ipfsdaemon
#xdg-open ipns://aragon.plasmmer.eth
xdg-open https://aragon.plasmmer.com #until IPFS issue is fixed
EOF
sudo chmod +x /usr/bin/aragon
sudo cat > /usr/share/applications/aragon.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Aragon
Comment=Participate on Internet-native organizations/enterprises (as BTC/ETH are the Internet-native money) or create your own!
Type=Application
Exec=aragon
Icon=aragon
Categories=Office;Blockchain;Finance;Ethereum;
Keywords=daos;govern;governance;organizations;decentralized;autonomous;tokens;ethereum;xdai;polygon
EOF
if [ ! -e /1/img/humanrepresentation ]; then sudo mkdir /1/img/humanrepresentation; fi
sudo ln -s /1/apps/aragon/action-create.ee78fef6.png /1/img/humanrepresentation/action-create.png
sudo ln -s /1/apps/aragon/activity-no-results.51fb2b93.png /1/img/humanrepresentation/look-at-phone.png

#echo "Setting autostart apps..."
#chmod +x /home/${flouser}/.config/autostart/teams.desktop

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

sudo rm -rf /usr/lib/floflis/layers/soil/to-merge/include-firstlogon
