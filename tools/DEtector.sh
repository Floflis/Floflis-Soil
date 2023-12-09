#if [ $(echo "$XDG_DATA_DIRS" | sed 's/.*\(xfce\|kde\|gnome\).*/\1/') = "" ]
#then
#  desktop=$XDG_CURRENT_DESKTOP
#else
#  desktop=$(echo "$XDG_DATA_DIRS" | sed 's/.*\(xfce\|kde\|gnome\).*/\1/')
#fi
#-

# checks if a program is installed
command_exist() {
    if ! command -v $1 &> /dev/null
    then
        echo "Install '$1' and run again."
        #exit
    else
        desktop="gnome"
    fi
}
#use "&>" as in https://stackoverflow.com/a/677212/5623661

# checking if grep and curl exist
command_exist gnome-shell
#command_exist curl

desktop=${desktop,,}  # convert to lower case
echo "$desktop"
#from https://unix.stackexchange.com/a/116694
#-Task: look for the other answers in https://unix.stackexchange.com/questions/116539/how-to-detect-the-desktop-environment-in-a-bash-script, so this method can be improved and have a wider coverage
