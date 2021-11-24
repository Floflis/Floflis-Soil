#!/bin/bash

echo "Building your desktop experience..."
cat >> /tmp/org-cinnamon <<EOF
[/]
desklet-snap-interval=25
enabled-applets=['panel1:right:11:show-desktop@cinnamon.org:1', 'panel1:left:2:grouped-window-list@cinnamon.org:2', 'panel1:right:1:systray@cinnamon.org:3', 'panel1:right:2:xapp-status@cinnamon.org:4', 'panel1:right:3:notifications@cinnamon.org:5', 'panel1:right:4:printers@cinnamon.org:6', 'panel1:right:5:removable-drives@cinnamon.org:7', 'panel1:right:6:keyboard@cinnamon.org:8', 'panel1:right:7:network@cinnamon.org:9', 'panel1:right:8:sound@cinnamon.org:10', 'panel1:right:9:power@cinnamon.org:11', 'panel1:right:10:calendar@cinnamon.org:12', 'panel1:right:0:weather@mockturtl:13', 'panel1:left:0:CinnVIIStarkMenu@NikoKrause:14']
enabled-desklets=@as []
enabled-extensions=['transparent-panels@germanfr']
next-applet-id=15
panel-edit-mode=false

[desktop/background]
picture-options='zoom'
picture-uri='file:///1/img/bg.png'

[desktop/background/slideshow]
delay=15
image-source='xml:///usr/share/gnome-background-properties/floflis-backgrounds.xml'

[desktop/interface]
cursor-theme='Floflis'
gtk-theme='Adapta'
icon-theme='Floflis'

[desktop/sound]
event-sounds=true
volume-sound-enabled=true
volume-sound-file='/1/sounds/Changing volume.ogg'

[desktop/wm/preferences]
theme='Adapta'

[settings-daemon/peripherals/keyboard]
numlock-state='off'

[sounds]
close-enabled=true
close-file='/1/sounds/Manipulating windows.ogg'
logout-enabled=true
logout-file='/1/sounds/Leaving.ogg'
map-enabled=true
map-file='/1/sounds/Manipulating windows.ogg'
maximize-enabled=true
maximize-file='/1/sounds/Manipulating windows.ogg'
minimize-enabled=true
minimize-file='/1/sounds/Manipulating windows.ogg'
notification-enabled=true
notification-file='/1/sounds/Notification.ogg'
plug-enabled=true
plug-file='/1/sounds/Inserting device.ogg'
switch-enabled=true
switch-file='/1/sounds/Switching workspace.ogg'
tile-enabled=true
tile-file='/1/sounds/Manipulating windows.ogg'
unmaximize-enabled=true
unmaximize-file='/1/sounds/Manipulating windows.ogg'
unplug-enabled=true
unplug-file='/1/sounds/Removing device.ogg'

[theme]
name='Eleganse-Floflis'
EOF
dconf load /org/cinnamon/ < /tmp/org-cinnamon
rm -f /tmp/org-cinnamon

cat >> /tmp/org-nemo-desktop <<EOF
[/]
computer-icon-visible=true
home-icon-visible=true
network-icon-visible=false
show-desktop-icons=true
trash-icon-visible=true
volumes-visible=false
EOF
dconf load /org/nemo/desktop/ < /tmp/org-nemo-desktop
rm -f /tmp/org-nemo-desktop

cat >> /tmp/org-gnome-terminal-legacy-profiles <<EOF
[/]
bold-is-bright=true
font='FantasqueSansMono Nerd Font 12'
use-system-font=false
EOF
dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < /tmp/org-gnome-terminal-legacy-profiles
rm -f /tmp/org-gnome-terminal-legacy-profiles

echo "Installing Starship..."
shit Qmf1XqY9vjU1yHDwEPj3hFBWJqtwGeUyoWPR77kYA7f65D
echo 'eval "$(starship init bash)"' >> /home/${flouser}/.bashrc

echo "Adding Starship to nushell..."
cat >> /home/${flouser}/.config/nu/config.toml <<EOF
startup = [
 "mkdir ~/.cache/starship",
 "starship init nu | save ~/.cache/starship/init.nu",
 "source ~/.cache/starship/init.nu"
]
prompt = "starship_prompt"
EOF

echo "Preparing to create your ETH address..."
bash /usr/lib/floflis/layers/soil/to-merge/ethgenerate.sh

echo "Installing Uniswap..."
tar -xzf include/uniswap.tar.gz
mv -f uniswap /1/apps
#ipfs pin add $(ipfs dns uniswap.eth)
ipfs pin add $(ethereal ens contenthash get --domain=uniswap.eth)
#ipfs add $(ipfs dns uniswap.eth)
#tmp=$(ipfs pin add $(ethereal ens contenthash get --domain=uniswap.eth) | tr -d "pinned " | tr -d " recursively")
#ipfs add $tmp
#ipfs get $(ipfs dns uniswap.eth) --output=/1/apps/uniswap
ipfs get $(ethereal ens contenthash get --domain=uniswap.eth) --output=/1/apps/uniswap
# to change: use a variable. test if ipfs dns result starts with /ipfs/, if not use ethereal ens contenthash get --domain=, and if not display an error
# commands to work on post-install:
#ipfs add -r /1/apps/uniswap
#ipfs dns uniswap.eth && ipfs dns uniswap.eth
#ipfs pin add $(ipfs dns uniswap.eth)
#ipfs ls $(ipfs dns uniswap.eth)
#ipfs pin add $(ipfs dns uniswap.eth)
#- this will have to work on user side (post-install), not only when installing
$maysudo cat > /usr/bin/uniswap <<EOF
#!/bin/bash

ipfs-desktop
xdg-open ipns://uniswap.eth
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

echo "Installing Hop protocol..."
tar -xzf include/hop.tar.gz
mv -f hop /1/apps
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
tar -xzf include/aragon.tar.gz
mv -f aragon /1/apps
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
$maysudo cat > /usr/bin/aragon <<EOF
#!/bin/bash

ipfs-desktop
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
$maysudo mkdir /1/img/humanrepresentation
ln -s /1/apps/aragon/action-create.ee78fef6.png /1/img/humanrepresentation/action-create.png
ln -s /1/apps/aragon/activity-no-results.51fb2b93.png /1/img/humanrepresentation/look-at-phone.png
