echo "Installing avatars..."
if [ ! -e /usr/share/pixmaps/faces/ubuntu ]; then $maysudo mkdir /usr/share/pixmaps/faces/ubuntu; $maysudo mv /usr/share/pixmaps/faces/legacy/ /usr/share/pixmaps/faces/*.jpg /usr/share/pixmaps/faces/*.png /usr/share/pixmaps/faces/ubuntu; fi

if [ ! -e /usr/share/cinnamon ]; then $maysudo mkdir /usr/share/cinnamon; fi
if [ ! -e /usr/share/cinnamon/faces ]; then $maysudo mkdir /usr/share/cinnamon/faces; fi
if [ ! -e /usr/share/cinnamon/faces/cinnamon ]; then $maysudo mkdir /usr/share/cinnamon/faces/cinnamon; fi

if [ -f /usr/share/cinnamon/faces/0_cars.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/0_cars.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/0_chess.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/0_chess.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/0_coffee.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/0_coffee.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/0_guitar.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/0_guitar.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/2_10.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/2_10.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/2_11.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/2_11.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/2_12.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/2_12.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/2_13.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/2_13.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/3_lightning.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/3_lightning.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/3_mountain.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/3_mountain.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/3_sky.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/3_sky.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/3_sunset.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/3_sunset.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/4_cinnamon.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/4_cinnamon.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/4_flower.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/4_flower.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/4_leaf.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/4_leaf.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/4_sunflower.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/4_sunflower.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/5_fish.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/5_fish.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/5_kitten.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/5_kitten.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/5_penguin.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/5_penguin.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/5_puppy.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/5_puppy.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/6_astronaut.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/6_astronaut.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/6_butterfly.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/6_butterfly.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/6_flake.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/6_flake.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/6_grapes.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/6_grapes.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_bat.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_bat.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_dog.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_dog.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_elephant.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_elephant.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_fox.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_fox.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_lion.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_lion.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_panda.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_panda.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_penguin.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_penguin.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_tucan.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_tucan.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/user-generic.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/user-generic.png /usr/share/cinnamon/faces/cinnamon; fi

tar -xzf Avatars.tar.gz
$maysudo rsync -av Avatars/. /usr/share/cinnamon/faces
$maysudo rm -rf Avatars
