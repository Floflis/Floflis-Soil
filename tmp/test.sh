#gnome_desktop=$(find /usr/share/xsessions -maxdepth 1 -name "gnome*.desktop" -print -quit 2>/dev/null && echo "gnome" || echo "no")
gnome_present=$(ls /usr/share/xsessions | grep -E '^gnome.*\.desktop$') && [[ -n "$gnome_present" ]] && echo "gnome" || echo "no"

