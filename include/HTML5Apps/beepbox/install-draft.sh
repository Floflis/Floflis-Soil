# FUTURELY PROBABLY WILL BE PART OF A FLOFLIS-PACKAGER METHOD ---->
echo "Installing BeepBox..."
cd include/HTML5Apps/beepbox
unzip BeepBox_4_1.zip
rm -r __MACOSX
mv BeepBox_4_1 beepbox
cp manifest.webapp beepbox/
cp package.json beepbox/
cp main.js beepbox/

cd beepbox

ln -s /1/Floflis/libs/node_modules
ln -s apple-touch-icon.png icon.png

echo "Installing BeepBox's icon..."
cp -f --preserve=all apple-touch-icon.png /usr/share/icons/hicolor/scalable/apps/beepbox.png
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f

echo "Converting BeepBox's webapp to floapps..."
application_id="$(jq -r '.id' manifest.webapp)"
application_exportsfolder="$(jq -r '.floflispackager.exportsfolder' manifest.webapp)"
application_type="$(jq -r '.application' manifest.webapp)"
#rocketlaunch_dir="$(echo $PWD)"

cd ..

rocketlaunch_dir="beepbox"

proceed () {
if [ "$application_type" = "app" ]; then
   application_extension="apps"
   #echo "apps"
fi

if [ "$application_type" = "game" ]; then
   application_extension="game"
   #echo "game"
fi

mkdir /tmp/floflis
mkdir /tmp/floflis/packager
mkdir /tmp/floflis/packager/application
cp -r "$application_exportsfolder" /tmp/floflis/packager/application/$application_id
cp "$rocketlaunch_dir/manifest.webapp" /tmp/floflis/packager/manifest.webapp
cd "/tmp/floflis/packager/application/$application_id"
rm -rf .git #tmp, this will be moved into a pre/post hook
rm -rf .github #tmp, this will be moved into a pre/post hook
cd /tmp/floflis/packager
tar -czvf $application_id.$application_extension application manifest.webapp
mv -f $application_id.$application_extension "$rocketlaunch_dir"
rm -rf /tmp/floflis/packager/application
rm -f /tmp/floflis/packager/manifest.webapp
cd "$rocketlaunch_dir"
echo "Exported to $application_id.$application_extension!"
exit 0
}

fail () {
echo "This application have no manifest.webapp."
echo "Please create it."
exit 1
}

if [ -f "$rocketlaunch_dir/manifest.webapp" ]; then # manifest.webapp file should always be at the root of the source
   proceed
else
   fail
fi

# <---- FUTURELY PROBABLY WILL BE PART OF A FLOFLIS-PACKAGER METHOD
