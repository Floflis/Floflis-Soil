if [ $(bash /usr/lib/floflis/layers/soil/tools/DEtector.sh) != "gnome" ] #loosely assumes it is Cinnamon just bc not GNOME ; have to later be improved!
   then
      echo "We're not on GNOME! Yeah!"
   else
      echo "I insist we're on GNOME"
fi
