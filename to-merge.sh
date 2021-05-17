#!/bin/bash

cat > /usr/share/applications/ipfs-handle-link.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Handler for ipfs:// URIs
Exec=xdg-open %u
StartupNotify=false
MimeType=x-scheme-handler/ipfs;
EOF

cat >> /usr/share/applications/x-cinnamon-mimeapps.list <<EOF
x-scheme-handler/ipfs=firefox.desktop;chromium.desktop;
EOF

cat > /usr/share/desktop-directories/Finance.directory <<EOF
[Desktop Entry]
Name=Finance
Comment=Financial applications
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=ethereum
Type=Directory
X-Ubuntu-Gettext-Domain=gnome-menus-3.0
EOF

cat > /usr/bin/uniswap <<EOF
#!/bin/bash

xdg-open ipfs://uniswap.eth
EOF
sudo chmod +x /usr/bin/uniswap
cat > /usr/share/applications/uniswap.desktop <<EOF
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

cat > /usr/bin/decentraland <<EOF
#!/bin/bash

xdg-open https://play.decentraland.org/
EOF
sudo chmod +x /usr/bin/decentraland
cat > /usr/share/applications/decentraland.desktop <<EOF
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

cat > /usr/bin/thesandbox <<EOF
#!/bin/bash

xdg-open https://www.sandbox.game/en/
EOF
sudo chmod +x /usr/bin/thesandbox
cat > /usr/share/applications/thesandbox.desktop <<EOF
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

sudo snap install mmex

sudo add-apt-repository ppa:openshot.developers/ppa && sudo apt-get update && sudo apt-get install openshot-qt
