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
