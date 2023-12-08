if [ $(echo "$XDG_DATA_DIRS" | sed 's/.*\(xfce\|kde\|gnome\).*/\1/') = "" ]
then
  desktop=$XDG_CURRENT_DESKTOP
else
  desktop=$(echo "$XDG_DATA_DIRS" | sed 's/.*\(xfce\|kde\|gnome\).*/\1/')
fi
#-
desktop=${desktop,,}  # convert to lower case
echo "$desktop"
#from https://unix.stackexchange.com/a/116694
#-Task: look for the other answers in https://unix.stackexchange.com/questions/116539/how-to-detect-the-desktop-environment-in-a-bash-script, so this method can be improved and have a wider coverage
