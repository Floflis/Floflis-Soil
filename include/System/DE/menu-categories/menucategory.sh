#!/bin/bash

cat > /usr/share/desktop-directories/Blockchain.directory <<EOF
[Desktop Entry]
Name=Blockchain
Comment=Blockchain Applications
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=ethereum
Type=Directory
X-Ubuntu-Gettext-Domain=gnome-menus-3.0
EOF

cp -f cinnamon-blockchain.directory /usr/share/desktop-directories/
cp -f patch/cinnamon-applications.menu /etc/xdg/menus/cinnamon-applications.menu

#echo "Finance category doesn't works, yet."# now it probably works, thanks to help from https://forums.linuxmint.com/viewtopic.php?t=291101

# futurely, write directly (by parsing) rather than overwriting/patching
