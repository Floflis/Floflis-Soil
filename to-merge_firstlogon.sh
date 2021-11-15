#!/bin/bash

echo "Installing Starship..."
shit Qmf1XqY9vjU1yHDwEPj3hFBWJqtwGeUyoWPR77kYA7f65D
echo 'eval "$(starship init bash)"' >> /home/${flouser}/.bashrc

cat >> /home/${flouser}/.config/nu/config.toml <<EOF
startup = [
 "mkdir ~/.cache/starship",
 "starship init nu | save ~/.cache/starship/init.nu",
 "source ~/.cache/starship/init.nu"
]
prompt = "starship_prompt"
EOF

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
