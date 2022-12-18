#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
flouser=$(logname)

unameOutM="$(uname -m)"
case "${unameOutM}" in
    i286)   flofarch="286";;
    i386)   flofarch="386";;
    i686)   flofarch="386";;
    x86_64) flofarch="amd64";;
    arm)    dpkg --print-flofarch | grep -q "arm64" && flofarch="arm64" || flofarch="arm";;
    riscv64) flofarch="riscv64"
esac

is_root=false
if [ "$([[ $UID -eq 0 ]] || echo "Not root")" = "Not root" ]
   then
      is_root=false
   else
      is_root=true
fi
maysudo=""
if [ "$is_root" = "false" ]
   then
      maysudo="sudo"
   else
      maysudo=""
fi

#- Floflis main Ubuntu ISO will use Ultimate layer. For Home layer, different ISO base: https://help.ubuntu.com/community/Installation/MinimalCD https://www.edivaldobrito.com.br/instalar-ambiente-cinnamon-3-0-no-ubuntu-16-04/

#- attempt to fix Cubic's custom name:
$maysudo sed -i 's/^PRETTY_NAME=" .*$/PRETTY_NAME=" Floflis 19 build 2112_X 'Eusoumafoca'"/' /usr/lib/os-release
$maysudo sed -i 's/^DISTRIB_DESCRIPTION=" .*$/DISTRIB_DESCRIPTION=" Floflis 19 build 2112_X 'Eusoumafoca'"/' /etc/lsb-release
# have to get it from config or json

if [ ! -f /etc/floflis-release ]; then $maysudo touch /etc/floflis-release; fi

echo "Installing neofetch..."
if [ ! -e /usr/lib/neofetch ]; then sudo mkdir /usr/lib/neofetch; fi
cd include/Terminal/neofetch
git checkout -f
sudo cp -r -f --preserve=all . /usr/lib/neofetch
$maysudo mv -f /usr/lib/neofetch/neofetch /usr/bin/neofetch
$maysudo chmod +x /usr/bin/neofetch
rm -rf .github #use noah to exclude everything except .git
rm -f CONTRIBUTING.md
rm -f LICENSE.md
rm -f Makefile
rm -f neofetch
rm -f neofetch.1
rm -f README.md
rm -f .travis.yml
cd "$SCRIPTPATH"
echo "Testing if neofetch works:"
neofetch

#echo "Installing xdotool..."
#$maysudo apt install xdotool
#echo "Is xdotool still useful?" # inspire on how firedoge is installed and how it opens an app without blocking the rest of script

#ipfs init
##bash ipfsdaemon > ipfs.log &
#ipfs daemon
#xdotool key Ctrl+d
#xdotool key Ctrl+d
# on Cubic, need to have IPFS running on host - until its fixed

# HOME LAYER -->
# Install IPFS-Desktop:
#echo "Installing IPFS Desktop..."
#if [ "$flofarch" = "amd64" ]; then
#   $maysudo dpkg -i include/deb\ packages/ipfs-desktop-0.17.0-linux-amd64.deb
#   rm -f /opt/IPFS\ Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs/ipfs && sudo ln -s /usr/bin/ipfs /opt/IPFS\ Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs
#   $maysudo cat >> /usr/bin/ipfsdaemon << ENDOFFILE
#ipfs-desktop
#ENDOFFILE
#   $maysudo chmod +x /usr/bin/ipfsdaemon
#fi
# <-- HOME LAYER

#echo "Installing ipfs-handle..." #this doesnt works yet
#$maysudo cat > /usr/share/applications/ipfs-handle-link.desktop <<EOF
#[Desktop Entry]
#Type=Application
#Name=Handler for ipfs:// URIs
#Exec=xdg-open %u
#StartupNotify=false
#MimeType=x-scheme-handler/ipfs;
#EOF
#$maysudo cat >> /usr/share/applications/x-cinnamon-mimeapps.list <<EOF
#x-scheme-handler/ipfs=firefox.desktop;chromium.desktop;
#EOF
#echo "ipfs-handle doesn't works, yet."

echo "Installing Finance category..." #this doesnt works yet
$maysudo cat > /usr/share/desktop-directories/Finance.directory <<EOF
[Desktop Entry]
Name=Finance
Comment=Financial applications
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=ethereum
Type=Directory
X-Ubuntu-Gettext-Domain=gnome-menus-3.0
EOF
echo "Finance category doesn't works, yet."

echo "Installing GDevelop..."
#- x32 is not available as ethereal isn't available for x32 yet
#      if [ "$flofarch" = "386" ]; then
#         tar -xzf include/HTML5Apps/386.tar.gz
#         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
#         $maysudo mv go-ipfs/ipfs /usr/bin
#         $maysudo rm -rf go-ipfs
#         chmod +x /usr/bin/ipfs
#         echo "Testing if IPFS works:"
#         ipfs
#fi
#-
if [ "$flofarch" = "amd64" ]; then
   tar -xzf include/HTML5Apps/gdevelop_amd64.tar.gz
   $maysudo rsync -av gdevelop /1/apps
   chmod +x /1/apps/gdevelop/gdevelop
   rm -rf gdevelop
   $maysudo cat > /usr/bin/gdevelop <<EOF
#!/bin/bash

cd /1/apps/gdevelop/
./gdevelop
EOF
   $maysudo chmod +x /usr/bin/gdevelop
   $maysudo cat > /usr/share/applications/gdevelop.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=GDevelop
Comment=Make games easily even if you don't know to program; even your grandma can.
Type=Application
Exec=gdevelop
Icon=gdevelop
Categories=Programming;Games;
Keywords=programming;games;event-sheet;development;
EOF
fi

echo "Installing Money Manager Ex..." #this doesnt works yet
$maysudo snap install mmex
echo "Money Manager Ex doesn't works, yet."

echo "Installing Openshot video editor..."
$maysudo add-apt-repository ppa:openshot.developers/ppa -y && sudo apt-get update -y && sudo apt-get install openshot-qt -y

echo "Installing Minetest..."
$maysudo apt install minetest

echo "Installing gbrainy and supertux..."
$maysudo apt install gbrainy
$maysudo apt install supertux

echo "Installing Photos..."
$maysudo apt install gnome-photos
echo "Installing Clock..."
$maysudo apt install gnome-clocks
echo "Installing KeePassXC..."
$maysudo apt install keepassxc
echo "Installing Weather..."
$maysudo apt install gnome-weather

echo "Installing floapps..."
cd to-merge/include-firstlogon/floapps
$maysudo bash install.sh
cd "$SCRIPTPATH"

echo "Installing nu-post-install..."
cd to-merge/include-firstlogon/nu-post-install
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
rm -f install.sh #use noah to exclude everything except .git
rm -f nu-script-handler
rm -f Tasks.txt
rm -f .gitattributes
rm -f .gitmeta
rm -rf rsc
cd "$SCRIPTPATH"

echo "Installing Decentraland weblink app..."
$maysudo cat > /usr/bin/decentraland <<EOF
#!/bin/bash

xdg-open https://play.decentraland.org/
EOF
$maysudo chmod +x /usr/bin/decentraland
$maysudo cat > /usr/share/applications/decentraland.desktop <<EOF
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

echo "Installing The Sandbox weblink app..."
$maysudo cat > /usr/bin/thesandbox <<EOF
#!/bin/bash

xdg-open https://www.sandbox.game/en/
EOF
$maysudo chmod +x /usr/bin/thesandbox
$maysudo cat > /usr/share/applications/thesandbox.desktop <<EOF
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

echo "Installing Cryptovoxels weblink app..."
$maysudo cat > /usr/bin/cryptovoxels <<EOF
#!/bin/bash

xdg-open https://www.cryptovoxels.com/play
EOF
$maysudo chmod +x /usr/bin/cryptovoxels
$maysudo cat > /usr/share/applications/cryptovoxels.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Cryptovoxels
Comment=Play in a open 3D voxels metaverse with other etherean players, and spend tokens to buy NFT items/wearables
Type=Application
Exec=cryptovoxels
Icon=cryptovoxels
Categories=Game;Simulation;Metaverse;Ethereum;
Keywords=metaverse;world;mining;tokens;ethereum;wearables;multiplayer;roleplaying;sandbox;voxels;
EOF

echo "Installing Audius weblink app..."
$maysudo cat > /usr/bin/audius <<EOF
#!/bin/bash

xdg-open https://audius.co/trending
EOF
$maysudo chmod +x /usr/bin/audius
$maysudo cat > /usr/share/applications/audius.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Audius
Comment=Discover underground music! Partnered with Tiktok. Higher quality than other music streamming services (even in their PRO/premium versions).
Type=Application
Exec=audius
Icon=audius
Categories=AudioVideo;Audio;
Keywords=music;blockchain;metaverse;nft;ethereum;
EOF

echo "Installing OpenSea weblink app..."
$maysudo cat > /usr/bin/opensea <<EOF
#!/bin/bash

xdg-open https://opensea.io/
EOF
$maysudo chmod +x /usr/bin/opensea
$maysudo cat > /usr/share/applications/opensea.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=OpenSea
Comment=Discover, collect, and sell extraordinary NFTs on the world's first & largest NFT marketplace
Type=Application
Exec=opensea
Icon=opensea
Categories=Internet;
Keywords=music;video;art;blockchain;metaverse;nft;ethereum;polygon;xdai;
EOF

echo "Installing icons..."
cd include/img/icons/Floflis
git checkout -f
cd ..
$maysudo rsync -av Floflis /usr/share/icons
cd Floflis
rm -f .gitattributes #use noah to exclude everything except .git
rm -f tasks.txt
rm -f 'personal research.txt'
rm -f index.theme
rm -f icon-theme.cache
rm -f cursor.theme
rm -rf 8x8 && rm -rf 8x8@2x && rm -rf 16x16 && rm -rf 16x16@2x && rm -rf 22x22 && rm -rf 24x24 && rm -rf 24x24@2x && rm -rf 32x32 && rm -rf 32x32@2x && rm -rf 48x48 && rm -rf 48x48@2x && rm -rf 64x64 && rm -rf 96x96 && rm -rf 128x128 && rm -rf 256x256 && rm -rf 256x256@2x && rm -rf 512x512 && rm -rf cursors && rm -rf scalable && rm -rf scalable-max-32
cd "$SCRIPTPATH"
if [ -f /tmp/cubicmode ]; then
   $maysudo rm -rf /usr/share/icons/Floflis/.git
fi

if [ ! -e /usr/share/icons/Yaru ]; then
   tar -xzf include/img/icons/Yaru.tar.gz
   $maysudo rsync -av Yaru /usr/share/icons
   $maysudo rm -rf Yaru
fi

if [ -e /usr/share/icons/Yaru ]; then
       echo "Proceeding with the install of Floflis icons..." #futurely, Floflis icons will be an separate package with its own installer
       if [ ! -e /usr/share/icons/ubuntu ]; then $maysudo mkdir /usr/share/icons/ubuntu; fi
       $maysudo mv -f /usr/share/icons/Yaru /usr/share/icons/ubuntu/Yaru
       $maysudo ln -s /usr/share/icons/Floflis /usr/share/icons/Yaru
       # echo "de-duplicing icons in hicolor..." sudo rm -f cinnamon-preferences-color.png && sudo rm -f csd-color.png && sudo ln -s preferences-color.png cinnamon-preferences-color.png && sudo ln -s preferences-color.png csd-color.png
       echo "de-duplicing some icons in Yaru..."
       echo "de-duplicing some icons in Yaru/apps..."
       $maysudo cp -f include/img/icons/to-merge_floflis-icons.sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/256x256@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/256x256/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/48x48@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/48x48/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/32x32@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/32x32/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/24x24@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/24x24/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/16x16@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       cd /usr/share/icons/ubuntu/Yaru/16x16/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
       #cd "$(dirname "${BASH_SOURCE[0]}")" #should work but isnt working
       cd "$SCRIPTPATH"
       $maysudo rm -f /tmp/to-merge_floflis-icons.sh
fi

echo "Installing icon for Explorer..."
$maysudo cat > /usr/share/applications/csd-automount.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Files
Name[am]=ፋይሎች
Name[bg]=Файлове
Name[ca]=Arxius
Name[cs]=Soubory
Name[da]=Filer
Name[de]=Dateien
Name[es]=Archivos
Name[eu]=Fitxategiak
Name[fr]=Fichiers
Name[hr]=Nemo
Name[hu]=Fájlok
Name[ko]=파일
Name[lt]=Failai
Name[nl]=Bestanden
Name[pl]=Pliki
Name[pt]=Ficheiros
Name[pt_BR]=Arquivos
Name[pt_PT]=Ficheiros
Name[ru]=Файлы
Name[sv]=Filer
Name[tr]=Dosyalar
Name[uk]=Файли
Name[zh_CN]=文件
Name[zh_HK]=檔案
Icon=system-file-manager
Exec=/usr/lib/x86_64-linux-gnu/cinnamon-settings-daemon/csd-automount
OnlyShowIn=X-Cinnamon;
NoDisplay=true
EOF

$maysudo cat > /usr/share/applications/nemo.desktop <<EOF
[Desktop Entry]
Name=Files
Name[am]=ፋይሎች
Name[ar]=الملفات
Name[bg]=Файлове
Name[ca]=Fitxers
Name[ca@valencia]=Fitxers
Name[cs]=Soubory
Name[cy]=Ffeiliau
Name[da]=Filer
Name[de]=Dateien
Name[el]=Αρχεία
Name[eo]=Dosieroj
Name[es]=Archivos
Name[et]=Failid
Name[eu]=Fitxategiak
Name[fi]=Tiedostot
Name[fr]=Fichiers
Name[fr_CA]=Fichiers
Name[he]=קבצים
Name[hr]=Nemo
Name[hu]=Fájlok
Name[id]=Berkas
Name[is]=Skrár
Name[kab]=Ifuyla
Name[ko]=파일
Name[lt]=Failai
Name[nl]=Bestanden
Name[pl]=Pliki
Name[pt]=Ficheiros
Name[pt_BR]=Arquivos
Name[ro]=Fișiere
Name[ru]=Файлы
Name[sk]=Súbory
Name[sl]=Datoteke
Name[sr]=Датотеке
Name[sr@latin]=Датотеке
Name[sv]=Filer
Name[th]=แฟ้ม
Name[tr]=Dosyalar
Name[uk]=Файли
Name[zh_CN]=文件
Name[zh_HK]=檔案
Comment=Access and organize files
Comment[am]=ፋይሎች ጋር መድረሻ እና ማደራጃ
Comment[ar]=الوصول إلى الملفات وتنظيمها
Comment[bg]=Достъп и управление на файлове
Comment[ca]=Organitzeu i accediu als fitxers
Comment[ca@valencia]=Organitzeu i accediu als fitxers
Comment[cs]=Přístup k souborům a jejich správa
Comment[cy]=Mynediad i drefnu ffeiliau
Comment[da]=Tilgå og organisér filer
Comment[de]=Dateien aufrufen und organisieren
Comment[el]=Πρόσβαση και οργάνωση αρχείων
Comment[en_GB]=Access and organise files
Comment[eo]=Atingi kaj organizi dosierojn
Comment[es]=Acceder a los archivos y organizarlos
Comment[et]=Ligipääs failidele ning failipuu korrastamine
Comment[eu]=Atzitu eta antolatu fitxategiak
Comment[fi]=Avaa ja järjestä tiedostoja
Comment[fr]=Accéder aux fichiers et les organiser
Comment[fr_CA]=Accéder aux fichiers et les organiser
Comment[he]=גישה לקבצים וארגונם
Comment[hr]=Pristupite i organizirajte datoteke
Comment[hu]=Fájlok elérése és rendszerezése
Comment[ia]=Acceder e organisar le files
Comment[id]=Akses dan kelola berkas
Comment[ie]=Accesse e ordina files
Comment[is]=Aðgangur og skipulag skráa
Comment[it]=Accede ai file e li organizza
Comment[kab]=Kcem udiɣ suddes ifuyla
Comment[ko]=파일 접근 및 정리
Comment[lt]=Gauti prieigą prie failų ir juos tvarkyti
Comment[nl]=Bestanden gebruiken en organiseren
Comment[pl]=Porządkowanie i dostęp do plików
Comment[pt]=Aceder e organizar ficheiros
Comment[pt_BR]=Acesse e organize arquivos
Comment[ro]=Accesează și organizează fișiere
Comment[ru]=Управление и доступ к файлам
Comment[sk]=Prístup a organizácia súborov
Comment[sl]=Dostop in razvrščanje datotek
Comment[sr]=Приступите датотекама и организујте их
Comment[sr@latin]=Приступите датотекама и организујте их
Comment[sv]=Kom åt och organisera filer
Comment[th]=เข้าถึงและจัดระเบียบแฟ้ม
Comment[tr]=Dosyalara eriş ve düzenle
Comment[uk]=Доступ до файлів та впорядковування файлів
Comment[zh_CN]=访问和组织文件
Comment[zh_HK]=存取與組織檔案
Exec=nemo %U
Icon=system-file-manager
# Translators: these are keywords of the file manager
Keywords=folders;filesystem;explorer;
Terminal=false
Type=Application
StartupNotify=false
Categories=GNOME;GTK;Utility;Core;
MimeType=inode/directory;application/x-gnome-saved-search;
Actions=open-home;open-computer;open-trash;

[Desktop Action open-home]
Name=Home
Name[af]=Tuis
Name[am]=ቤት
Name[ar]=المجلد الرئيسي
Name[be]=Дом
Name[bg]=Домашна папка
Name[bn]=হোম
Name[bs]=Početni direktorij
Name[ca]=Carpeta de l'usuari
Name[ca@valencia]=Carpeta de l'usuari
Name[cs]=Domov
Name[cy]=Cartref
Name[da]=Hjem
Name[de]=Persönlicher Ordner
Name[el]=Προσωπικός φάκελος
Name[eo]=Hejmo
Name[es]=Carpeta personal
Name[et]=Kodu
Name[eu]=Karpeta nagusia
Name[fi]=Koti
Name[fr]=Dossier personnel
Name[fr_CA]=Dossier personnel
Name[ga]=Baile
Name[gd]=Dhachaigh
Name[gl]=Cartafol persoal
Name[he]=בית
Name[hr]=Osobna mapa
Name[hu]=Saját mappa
Name[ia]=Al domo
Name[id]=Beranda
Name[ie]=Hem
Name[is]=Heimamappa
Name[ja]=ホーム
Name[kab]=Agejdan
Name[kk]=Үй
Name[kn]=ಮನೆ
Name[ko]=홈
Name[ku]=Mal
Name[lt]=Namai
Name[ml]=ആസ്ഥാനം
Name[mr]=मुख्य
Name[ms]=Rumah
Name[nb]=Hjem
Name[nl]=Persoonlijke map
Name[oc]=Dorsièr personal
Name[pl]=Katalog domowy
Name[pt]=Pasta Pessoal
Name[pt_BR]=Pasta pessoal
Name[ro]=Dosar personal
Name[ru]=Домашняя папка
Name[sk]=Domov
Name[sl]=Domov
Name[sr]=Почетна
Name[sr@latin]=Početna
Name[sv]=Hem
Name[ta]=இல்லம்
Name[tg]=Асосӣ
Name[th]=บ้าน
Name[tr]=Ev Dizini
Name[uk]=Домівка
Name[ur]=المنزل
Name[vi]=Nhà
Name[zh_CN]=主目录
Name[zh_HK]=家
Name[zh_TW]=家
Exec=nemo %U

[Desktop Action open-computer]
Name=Computer
Name[af]=Rekenaar
Name[am]=ኮምፒዩተር
Name[ar]=الكمبيوتر
Name[ast]=Ordenador
Name[be]=Кампутар
Name[bg]=Компютър
Name[bn]=কম্পিউটার
Name[bs]=Računar
Name[ca]=Ordinador
Name[ca@valencia]=Ordinador
Name[cs]=Počítač
Name[cy]=Cyfrifiadur
Name[de]=Rechner
Name[el]=Υπολογιστής
Name[eo]=Komputilo
Name[es]=Equipo
Name[et]=Arvuti
Name[eu]=Ordenagailua
Name[fi]=Tietokone
Name[fr]=Poste de travail
Name[fr_CA]=Poste de travail
Name[gd]=Coimpiutair
Name[gl]=Computador
Name[he]=מחשב
Name[hr]=Računalo
Name[hu]=Számítógép
Name[ia]=Computator
Name[id]=Komputer
Name[ie]=Computator
Name[is]=Tölva
Name[ja]=コンピュータ
Name[kab]=Aselkim
Name[kk]=Компьютер
Name[kn]=ಗಣಕ
Name[ko]=컴퓨터
Name[ku]=Komputer
Name[lt]=Kompiuteris
Name[ml]=കമ്പ്യൂട്ടർ
Name[mr]=संगणक
Name[ms]=Komputer
Name[nb]=Datamaskin
Name[nn]=Datamaskin
Name[oc]=Ordenador
Name[pl]=Komputer
Name[pt]=Computador
Name[pt_BR]=Computador
Name[ru]=Компьютер
Name[sk]=Počítač
Name[sl]=Računalnik
Name[sq]=Kompjuteri
Name[sr]=Рачунар
Name[sr@latin]=Računar
Name[sv]=Dator
Name[ta]=கணினி
Name[tg]=Компютер
Name[th]=คอมพิวเตอร์
Name[tr]=Bilgisayar
Name[uk]=Комп’ютер
Name[ur]=کمپیوٹر
Name[vi]=Máy tính
Name[zh_CN]=计算机
Name[zh_HK]=電腦
Name[zh_TW]=電腦
Exec=nemo computer:///

[Desktop Action open-trash]
Name=Trash
Name[af]=Asblik
Name[am]=ቆሻሻ
Name[ar]=سلة المهملات
Name[ast]=Papelera
Name[be]=Сметніца
Name[bg]=Кошче
Name[bn]=ট্র্যাশ
Name[bs]=Smeće
Name[ca]=Paperera
Name[ca@valencia]=Paperera
Name[cs]=Koš
Name[cy]=Sbwriel
Name[da]=Papirkurv
Name[de]=Papierkorb
Name[el]=Απορρίμματα
Name[en_GB]=Rubbish Bin
Name[eo]=Rubujo
Name[es]=Papelera
Name[et]=Prügi
Name[eu]=Zakarrontzia
Name[fi]=Roskakori
Name[fr]=Corbeille
Name[fr_CA]=Corbeille
Name[ga]=Bruscar
Name[gd]=An sgudal
Name[gl]=Lixo
Name[he]=אשפה
Name[hr]=Smeće
Name[hu]=Kuka
Name[ia]=Immunditia
Name[id]=Tempat sampah
Name[ie]=Paper-corb
Name[is]=Rusl
Name[it]=Cestino
Name[ja]=ゴミ箱
Name[kab]=Iḍumman
Name[kk]=Себет
Name[kn]=ಕಸಬುಟ್ಟಿ
Name[ko]=휴지통
Name[ku]=Avêtî
Name[lt]=Šiukšlinė
Name[ml]=ട്രാഷ്
Name[mr]=कचरापेटी
Name[ms]=Tong Sampah
Name[nb]=Papirkurv
Name[nds]=Papierkorb
Name[nl]=Prullenbak
Name[nn]=Papirkorg
Name[oc]=Escobilhièr
Name[pl]=Kosz
Name[pt]=Lixo
Name[pt_BR]=Lixeira
Name[ro]=Coș de gunoi
Name[ru]=Корзина
Name[sk]=Kôš
Name[sl]=Smeti
Name[sq]=Koshi
Name[sr]=Смеће
Name[sr@latin]=Kanta
Name[sv]=Papperskorg
Name[ta]=குப்பைத் தொட்டி
Name[tg]=Сабад
Name[th]=ถังขยะ
Name[tr]=Çöp
Name[uk]=Смітник
Name[ur]=ردی
Name[vi]=Thùng rác
Name[zh_CN]=回收站
Name[zh_HK]=垃圾桶
Name[zh_TW]=回收筒
Exec=nemo trash:///
EOF

echo "Installing branding..."
if [ ! -e /usr/share/cups/data/ubuntu ]; then $maysudo mkdir /usr/share/cups/data/ubuntu; fi
$maysudo mv -f /usr/share/cups/data/default-testpage.pdf /usr/share/cups/data/ubuntu/default-testpage.pdf
$maysudo cp -f include/img/default-testpage.pdf /usr/share/cups/data/default-testpage.pdf

echo "Installing installer's slideshow..."
if [ -e /usr/share/ubiquity-slideshow ]; then
    if [ ! -e /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu; fi
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/screenshots/welcome.png /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/screenshots/photos.png /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu
#-
    if [ ! -e /usr/share/ubiquity-slideshow/slides/icons/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/icons/ubuntu; fi
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/icons/firefox.png /usr/share/ubiquity-slideshow/slides/icons/ubuntu
#-
    if [ ! -e /usr/share/ubiquity-slideshow/slides/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/ubuntu; fi
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/welcome.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/music.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/accessibility.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/browse.html /usr/share/ubiquity-slideshow/slides/ubuntu
#-
    if [ ! -e /usr/share/ubiquity-slideshow/slides/link/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/link/ubuntu; fi
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/background.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/bullet-point.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/arrow-back.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/arrow-next.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
#-    
    cd include/System/ubiquity-slideshow
    git checkout -f
    cd ..
    $maysudo rsync -av ubiquity-slideshow /usr/share
    cd ubiquity-slideshow
    rm -f .gitattributes #use noah to exclude everything except .git
    rm -rf slides
    rm -f slideshow.conf
    cd "$SCRIPTPATH"
fi

echo "Installing img..."
if [ ! -e /1/img ]; then $maysudo mkdir /1/img; fi
#-
$maysudo cp -f include/img/OSlogotype.png /1/img/OSlogotype.png
$maysudo cp -f include/img/logo.png /1/img/logo.png
$maysudo cp -f include/img/watermark.png /1/img/watermark.png
#-
if [ ! -e /1/img/networks ]; then $maysudo mkdir /1/img/networks; fi
$maysudo cp -f include/img/networks/ethereum.svg /1/img/networks/ethereum.svg
$maysudo cp -f include/img/networks/polygon.svg /1/img/networks/polygon.svg
$maysudo cp -f include/img/networks/xdai.svg /1/img/networks/xdai.svg
#-
$maysudo cp -f include/img/token.png /1/img/token.png

echo "Installing backgrounds..."
$maysudo cp -f include/img/Backgrounds/bg.png /1/img/bg.png
$maysudo cp -f include/img/Backgrounds/lockscreen.png /1/img/lockscreen.png
#-
if [ ! -e /usr/share/backgrounds/ubuntu ]; then $maysudo mkdir /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/brad-huchteman-stone-mountain.jpg ]; then $maysudo mv -f /usr/share/backgrounds/brad-huchteman-stone-mountain.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/hardy_wallpaper_uhd.png ]; then $maysudo mv -f /usr/share/backgrounds/hardy_wallpaper_uhd.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/joshua-coleman-something-yellow.jpg ]; then $maysudo mv -f /usr/share/backgrounds/joshua-coleman-something-yellow.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/matt-mcnulty-nyc-2nd-ave.jpg ]; then $maysudo mv -f /usr/share/backgrounds/matt-mcnulty-nyc-2nd-ave.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/ryan-stone-skykomish-river.jpg ]; then $maysudo mv -f /usr/share/backgrounds/ryan-stone-skykomish-river.jpg /usr/share/backgrounds/ubuntu; fi
$maysudo cp -f /usr/share/backgrounds/warty-final-ubuntu.png /usr/share/backgrounds/ubuntu/warty-final-ubuntu.png
$maysudo rm -f /usr/share/backgrounds/warty-final-ubuntu.png
$maysudo ln -s /1/img/bg.png /usr/share/backgrounds/warty-final-ubuntu.png
#-
tar -xzf include/img/Backgrounds/Backgrounds.tar.gz
$maysudo rsync -av Backgrounds/. /usr/share/backgrounds
$maysudo rm -rf Backgrounds
#-
$maysudo cp -f include/img/Backgrounds/floflis-backgrounds.xml /usr/share/gnome-background-properties/floflis-backgrounds.xml

echo "Updating default background..."
if [ ! -e /usr/share/wallpapers/FuturePrototype/debian ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/debian; fi
if [ -e /usr/share/wallpapers/FuturePrototype/contents ]; then $maysudo mv /usr/share/wallpapers/FuturePrototype/contents /usr/share/wallpapers/FuturePrototype/debian/contents; fi
if [ ! -e /usr/share/wallpapers/FuturePrototype/contents ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/contents; fi
if [ ! -e /usr/share/wallpapers/FuturePrototype/contents/images ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/contents/images; fi
if [ -f /usr/share/wallpapers/FuturePrototype/gnome-background.xml ]; then $maysudo mv /usr/share/wallpapers/FuturePrototype/gnome-background.xml /usr/share/wallpapers/FuturePrototype/debian/gnome-background.xml; fi
$maysudo ln -s /1/img/bg.png /usr/share/wallpapers/FuturePrototype/contents/images/1680x1050.png

echo "Installing avatars..."
if [ ! -e /usr/share/cinnamon ]; then $maysudo mkdir /usr/share/cinnamon; fi
if [ ! -e /usr/share/cinnamon/faces ]; then $maysudo mkdir /usr/share/cinnamon/faces; fi
if [ ! -e /usr/share/cinnamon/faces/cinnamon ]; then $maysudo mkdir /usr/share/cinnamon/faces/cinnamon; fi
#-
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

tar -xzf include/img/Avatars.tar.gz
$maysudo rsync -av Avatars/. /usr/share/cinnamon/faces
$maysudo rm -rf Avatars

echo "Installing sounds..."
if [ ! -e /1/sounds ]; then $maysudo mkdir /1/sounds; fi
$maysudo cp -f include/sounds/presentation.ogg /1/sounds/presentation.ogg

#- Deduplicate Ubuntu's login sound
if [ -f /usr/share/sounds/Yaru/stereo/system-ready.oga ]; then
if [ -f /usr/share/sounds/Yaru/stereo/desktop-login.oga ]; then
$maysudo rm -f /usr/share/sounds/Yaru/stereo/system-ready.oga && $maysudo ln -s 'desktop-login.oga' /usr/share/sounds/Yaru/stereo/system-ready.oga
fi
fi

# BASE LAYER -->
# Base sounds
$maysudo cp -f include/sounds/Base/Changing\ volume.ogg /1/sounds/Changing\ volume.ogg
$maysudo cp -f include/sounds/Base/Inserting\ device.ogg /1/sounds/Inserting\ device.ogg
$maysudo cp -f include/sounds/Base/Leaving.ogg /1/sounds/Leaving.ogg
$maysudo cp -f include/sounds/Base/Manipulating\ windows.ogg /1/sounds/Manipulating\ windows.ogg
$maysudo cp -f include/sounds/Base/Notification.ogg /1/sounds/Notification.ogg
$maysudo cp -f include/sounds/Base/Removing\ device.ogg /1/sounds/Removing\ device.ogg
$maysudo cp -f include/sounds/Base/Switching\ workspace.ogg /1/sounds/Switching\ workspace.ogg
$maysudo cp -f include/sounds/Base/Starting.ogx /1/sounds/Starting.ogx

if [ ! -e /usr/share/sounds/Yaru/stereo/ubuntu ]; then $maysudo mkdir /usr/share/sounds/Yaru/stereo/ubuntu; fi
if [ -f /usr/share/sounds/Yaru/stereo/desktop-login.oga ]; then $maysudo mv -f /usr/share/sounds/Yaru/stereo/desktop-login.oga /usr/share/sounds/Yaru/stereo/ubuntu; fi
if [ -f /usr/share/sounds/Yaru/stereo/system-ready.oga ]; then $maysudo mv -f /usr/share/sounds/Yaru/stereo/system-ready.oga /usr/share/sounds/Yaru/stereo/ubuntu; fi
$maysudo ln -s /1/sounds/Starting.ogx /usr/share/sounds/Yaru/stereo/desktop-login.oga
# <-- BASE LAYER

# HOME LAYER -->
# Home sounds patch
$maysudo cp -f include/sounds/Base/Home/Dialog.ogg /1/sounds/Dialog.ogg
$maysudo cp -f include/sounds/Base/Home/Navigation.ogg /1/sounds/Navigation.ogg
$maysudo cp -f include/sounds/Base/Home/Notification.ogg /1/sounds/Notification.ogg
$maysudo cp -f include/sounds/Base/Home/Notification\ Important.flac /1/sounds/Notification\ Important.flac
$maysudo cp -f include/sounds/Base/Home/System\ Logon.oga /1/sounds/System\ Logon.oga
if [ -f /1/sounds/Starting.ogx ]; then $maysudo rm -f /1/sounds/Starting.ogx; fi
$maysudo ln -s /1/sounds/System\ Logon.oga /1/sounds/Starting.ogx
# <-- HOME LAYER

echo "Installing Cinnamon 4.8..."
$maysudo add-apt-repository ppa:wasta-linux/cinnamon-4-8
$maysudo apt update
$maysudo apt install cinnamon-desktop-environment
#https://www.tecmint.com/install-cinnamon-desktop-in-ubuntu-fedora-workstations/

$maysudo apt --fix-broken install

echo "Installing Cinnamon applets, desklets and extensions..."
tar -xzf include/home-daniell-.local-share-cinnamon_usr-share-cinnamon.tar.gz
$maysudo rsync -av cinnamon/. /usr/share/cinnamon
$maysudo rm -rf cinnamon

echo "Installing main theme..."
tar -xzf include/Theme/Eleganse-Floflis.tar.gz
$maysudo rsync -av Eleganse-Floflis /usr/share/themes
$maysudo rm -rf Eleganse-Floflis
#$maysudo rm -rf /usr/share/themes/Eleganse-Floflis/.git
#-
tar -xzf include/Theme/Adapta.tar.gz
$maysudo rsync -av Adapta /usr/share/themes
$maysudo rm -rf Adapta
#-
tar -xzf include/Theme/Adapta-Nokto.tar.gz
$maysudo rsync -av Adapta-Nokto /usr/share/themes
$maysudo rm -rf Adapta-Nokto

# Install geth:
echo "Installing geth..."
#- x32 is not available as ethereal isn't available for x32 yet
#      if [ "$flofarch" = "386" ]; then
#         tar -xzf include/System/ethereum/386.tar.gz
#         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
#         $maysudo mv go-ipfs/ipfs /usr/bin
#         $maysudo rm -rf go-ipfs
#         chmod +x /usr/bin/ipfs
#         echo "Testing if IPFS works:"
#         ipfs
#fi
if [ "$flofarch" = "amd64" ]; then
   tar -xzf include/System/ethereum/geth-linux-amd64-1.10.11-7231b3ef.tar.gz
   $maysudo mv geth-linux-amd64-*-*/geth /usr/bin
   chmod +x /usr/bin/geth
   rm -rf geth-linux-amd64-1.10.11-7231b3ef
   echo "Testing if geth works:"
   geth -h
fi

echo "Fixing Terminal's name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Witchcraft"/' /usr/share/applications/org.gnome.Terminal.desktop
$maysudo cat > /usr/share/applications/org.gnome.Terminal.desktop <<EOF
[Desktop Entry]
# VERSION=3.36.2
Name=Witchcraft
Comment=Use the command line
Keywords=shell;prompt;command;commandline;cmd;
TryExec=gnome-terminal
Exec=gnome-terminal
Icon=org.gnome.Terminal
Type=Application
Categories=GNOME;GTK;System;TerminalEmulator;
StartupNotify=true
X-GNOME-SingleWindow=false
OnlyShowIn=GNOME;Unity;
Actions=new-window;preferences;
X-Ubuntu-Gettext-Domain=gnome-terminal

[Desktop Action new-window]
Name=New Window
Exec=gnome-terminal --window

[Desktop Action preferences]
Name=Preferences
Exec=gnome-terminal --preferences
EOF

echo "Fixing Cam's name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Cam"/' /usr/share/applications/org.gnome.Cheese.desktop
$maysudo cat > /usr/share/applications/org.gnome.Cheese.desktop <<EOF
[Desktop Entry]
Name=Cam
GenericName=Webcam Booth
Comment=Take photos and videos with your webcam, with fun graphical effects
# Translators: Search terms to find this application. Do NOT translate or localize the semicolons! The list MUST also end with a semicolon!
Keywords=photo;video;webcam;
Exec=cheese
Terminal=false
Type=Application
StartupNotify=true
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=org.gnome.Cheese
Categories=GNOME;AudioVideo;Video;Recorder;
DBusActivatable=true
X-Ubuntu-Gettext-Domain=cheese
EOF

echo "Fixing Music's name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Music"/' /usr/share/applications/rhythmbox.desktop
$maysudo cat > /usr/share/applications/rhythmbox.desktop <<EOF
[Desktop Entry]
Name=Music
GenericName=Music Player
X-GNOME-FullName=Rhythmbox Music Player
Comment=Play and organize your music collection
Keywords=Audio;Song;MP3;CD;Podcast;MTP;iPod;Playlist;Last.fm;UPnP;DLNA;Radio;
Exec=rhythmbox %U
Terminal=false
Type=Application
Icon=org.gnome.Rhythmbox
X-GNOME-DocPath=rhythmbox/rhythmbox.xml
Categories=GNOME;GTK;AudioVideo;Audio;Player;
MimeType=application/x-ogg;application/ogg;audio/x-vorbis+ogg;audio/vorbis;audio/x-vorbis;audio/x-scpls;audio/x-mp3;audio/x-mpeg;audio/mpeg;audio/x-mpegurl;audio/x-flac;audio/mp4;audio/x-it;audio/x-mod;audio/x-s3m;audio/x-stm;audio/x-xm;
StartupNotify=true
X-GNOME-Bugzilla-Bugzilla=GNOME
X-GNOME-Bugzilla-Product=rhythmbox
X-GNOME-Bugzilla-Component=general
X-GNOME-Bugzilla-OtherBinaries=rhythmbox-client;rhythmbox-metadata;
X-GNOME-Bugzilla-Version=3.4.4
X-GNOME-UsesNotifications=true
Actions=PlayPause;Next;Previous;StopQuit;
X-Ubuntu-Gettext-Domain=rhythmbox

[Desktop Action PlayPause]
Name=Play/Pause
Exec=rhythmbox-client --play-pause

[Desktop Action Next]
Name=Next
Exec=rhythmbox-client --next

[Desktop Action Previous]
Name=Previous
Exec=rhythmbox-client --previous

[Desktop Action StopQuit]
Name=Stop & Quit
Exec=rhythmbox-client --quit
EOF

# Prepare to replace 1inch to better alternative (should also support XDai) ----------------------------------------------------->
#ipfs add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs pin add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs get $(ethereal ens contenthash get --domain=1inch.eth) --output=/1/apps/1inch
# commands to work on post-install:
#ipfs add -r /1/apps/1inch
#ipfs pin add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs ls $(ethereal ens contenthash get --domain=1inch.eth)
# this will have to work on user side (post-install), not only when installing
#$maysudo cat > /usr/bin/1inch <<EOF
#!/bin/bash
#
#ipfs-desktop
#xdg-open ipns://1inch.eth
#EOF
#$maysudo chmod +x /usr/bin/1inch
#$maysudo cat > /usr/share/applications/1inch.desktop <<EOF
#[Desktop Entry]
#Encoding=UTF-8
#Name=1inch
#Comment=Swap ETH and tokens on multiple exchanges
#Type=Application
#Exec=1inch
#Icon=1inch
#Categories=Finance;Ethereum;
#Keywords=swap;exchange;tokens;ethereum;
#EOF
# <----------------------------------------------------- Prepare to replace 1inch to better alternative (should also support XDai)

# Install git-LFS:
 echo "git-LFS is a need for supporting large file storage in git. Only install it if you're a developer in need of it."
 echo "Do you want to install git-LFS? [Y/n]"
 read insgitlfs
 case $insgitlfs in
    [nN])
       echo "${ok}"
       break ;;
    [yY])
       echo "Installing git-LFS..."
             if [ "$flofarch" = "386" ]; then
          $maysudo gdebi include/VCS/git-LFS/git-lfs_2.9.2_i386.deb
          echo "Testing if git-LFS works:"
          git lfs
 fi
       if [ "$flofarch" = "amd64" ]; then
          $maysudo gdebi include/VCS/git-LFS/git-lfs_2.9.2_amd64.deb
          echo "Testing if git-LFS works:"
          git lfs
 fi
       break ;;
    *)
       echo "${invalid}" ;;
 esac
 
echo "Installing 01 VCS..."
cd include/VCS/01
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
rm -f install.sh #use noah to exclude everything except .git
rm -f 01
rm -f git
rm -f README.md
rm -f recipe.json
rm -f Tasks.txt
rm -f .gitignore
rm -f .gitmeta
cd "$SCRIPTPATH"
echo "Testing if 01 works:"
01

echo "Installing Pijul VCS (you did great, elder git)..."
if [ "$flofarch" = "amd64" ]; then
   tar -xzf include/VCS/pijul.tar.gz
   $maysudo mv -f pijul /usr/bin/pijul
   $maysudo chmod +x /usr/bin/pijul
   $maysudo mv -f libpijul_macros.so /usr/lib/x86_64-linux-gnu/libpijul_macros.so #wrong directory but may work
   $maysudo chmod +x /usr/lib/x86_64-linux-gnu/libpijul_macros.so #wrong directory but may work
   $maysudo mv libxxhash* -f /usr/lib/x86_64-linux-gnu
   echo "Testing if Pijul works:"
   pijul
fi

if [ "$flofarch" = "amd64" ]; then
   echo "Installing gix (you did great, elder perl git)..."
   tar -xzf include/VCS/gix-max-v0.10.0-x86_64-unknown-linux-musl.tar.gz
   $maysudo mv -f gix-max-v0.10.0-x86_64-unknown-linux-musl/gix  /usr/bin/gix
   $maysudo chmod +x /usr/bin/gix
   $maysudo mv -f gix-max-v0.10.0-x86_64-unknown-linux-musl/gixp  /usr/bin/gixp
   $maysudo chmod +x /usr/bin/gixp
   rm -rf gix-max-v0.10.0-x86_64-unknown-linux-musl
   echo "Testing if gix works:"
   gix
fi

echo "Adding bulbasaur.json..."
$maysudo cp -f include/System/bulbasaur.json /1/bulbasaur.json

#gnome-terminal --tab --title="Installing NodeJS" -- /bin/sh -c 'bash install-node.sh; exec bash'
#(gnome-terminal --tab --title="Installing NodeJS..." -- /bin/sh -c 'bash install-node.sh; exec bash' &)

# HOME LAYER -->
echo "Installing Floflis Central..."

#----> merge into floflis-packager/floflis-application-handler
tar -C /1/apps -xzf include/HTML5Apps/central.apps
mkdir /1/apps/central
mv -f /1/apps/manifest.webapp /1/apps/central/
cd /1/apps/application/central
cp -rf . /1/apps/central/
cd ../..
rm -rf application
#<---- merge into floflis-packager/floflis-application-handler

$maysudo mv /usr/bin/central /usr/lib/floflis/layers/core
$maysudo cp -f to-merge/central /usr/bin/central
$maysudo chmod +x /usr/bin/central
$maysudo cat > /usr/share/applications/central.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Central
Comment=Change settings, view your Dashboard with token balances, view your Profile, etc.
Type=Application
Exec=central
Icon=central
Categories=System;
Keywords=Preferences;Settings;Central;tokens;ethereum;xdai;polygon
EOF
# <-- HOME LAYER

echo "Installing FantasqueSansMono font (ComicSans haters gonna hate but its cute <3)..."
unzip include/Terminal/nerdyfonts/FantasqueSansMono.zip
$maysudo mv *.ttf *.TTF /usr/share/fonts/truetype/
#sudo mv *.otf *.OTF /usr/share/fonts/opentype

echo "Installing Sh it..."
cd include/Tools/shexec
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
rm -f install.sh #use noah to exclude everything except .git
rm -f README.md
rm -f shit
rm -f .gitmeta
sudo apt install curl
cd "$SCRIPTPATH"

if [ "$flofarch" = "amd64" ]; then
echo "Installing nushell..."
tar -xzf include/Terminal/nushell/nu_0_44_0_linux.tar.gz
$maysudo mv -f nu_0_44_0_linux/nushell-0.44.0/nu /bin/nu
$maysudo chmod +x /bin/nu
rm -rf nu_0_44_0_linux
echo "/bin/nu" | $maysudo tee -a /etc/shells
#-<- should check if line is already added, before re-adding!
chsh -s /bin/nu
#echo "Testing if nushell works:"
#nu
# introduce in next build
fi

echo "Installing Witchcraft Candy Colors..."
cd include/Terminal/witchcraft-candy-colors
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
rm -f install.sh #use noah to exclude everything except .git
rm -rf colors
rm -rf src
rm -f INSTALL.md
rm -f LICENSE
rm -f readme.md
rm -f screenshot.png
cd "$SCRIPTPATH"

echo "Installing Starship..."
if [ "$flofarch" = "amd64" ]; then
#shit Qmf1XqY9vjU1yHDwEPj3hFBWJqtwGeUyoWPR77kYA7f65D
#curl -sS https://starship.rs/install.sh | sh
#curl -sS https://gateway.pinata.cloud/ipfs/Qmf1XqY9vjU1yHDwEPj3hFBWJqtwGeUyoWPR77kYA7f65D | sh
#curl -sS https://raw.githubusercontent.com/starship/starship/master/install/install.sh | sh
tar -xzf include/Terminal/starship/starship-x86_64-unknown-linux-gnu.tar.gz
$maysudo rm -f /usr/local/bin/starship
$maysudo mv -f starship /bin/starship
$maysudo chmod +x /bin/starship
echo 'eval "$(starship init bash)"' >> /home/${flouser}/.bashrc # configure Starship for Bash
#-<- should check if line is already added, before re-adding!
#cat >> /home/$flouser/.config/mimeapps.list <<EOF
#
#EOF
## this is continuously adding the same entries to mimeapps.list and have to be fixed
#Add the following to the end of your Nushell env file (find it by running $nu.env-path in Nushell):
#
#mkdir ~/.cache/starship
#starship init nu | save ~/.cache/starship/init.nu
#
#And add the following to the end of your Nushell configuration (find it by running $nu.config-path):
#
#source ~/.cache/starship/init.nu
#-
#https://starship.rs/config/#prompt
#https://starship.rs/presets/pastel-powerline.html
fi

echo "Installing Hugo (you did great, elder blogspot.com)..."
if [ "$flofarch" = "386" ]; then
   $maysudo dpkg -i include/deb\ packages/hugo/hugo_0.89.2_Linux-32bit.deb
   echo "Testing if Hugo works:"
   hugo -h
fi
if [ "$flofarch" = "amd64" ]; then
   $maysudo dpkg -i include/deb\ packages/hugo/hugo_extended_0.89.2_Linux-64bit.deb
   echo "Testing if Hugo works:"
   hugo -h
fi

echo "Installing unzip..."
$maysudo apt install unzip

# HOME LAYER -->
echo "Installing Etcher (you are still great, Rufus)..."
if [ "$flofarch" = "amd64" ]; then
   $maysudo dpkg -i include/deb\ packages/balena-etcher-electron_1.6.0_amd64.deb
fi
# <-- HOME LAYER

echo "Installing Audacity (12.0 MB download; 52.2 MB installed)..."
$maysudo apt install audacity

echo "Installing OBS (17.0 MB download; 85.8 MB installed)..."
$maysudo apt install obs-studio

echo "Installing Gnome GAMES (465 kB download; 2,745 kB installed)..."
$maysudo apt install gnome-games-app

echo "Installing online..."
cd include/Tools/online
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
rm -f install.sh #use noah to exclude everything except .git
rm -f README.txt
rm -f online
rm -f README.md
rm -f 'SRC At ETH💎💌.txt'
cd "$SCRIPTPATH"

echo "Installing mlq..."
cd include/Tools/mlq
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
rm -f install.sh #use noah to exclude everything except .git
rm -f README.md
rm -f mlq
rm -f dependencies.txt
rm -f mlq-parser.sh
rm -f mlq-parser_worker.sh
rm -f sample.html
rm -f Tasks.txt
rm -f .gitmeta
rm -f 'SRC At ETH💎💌.txt'
cd "$SCRIPTPATH"

echo "Installing ethgas..."
cd include/Tools/ethgas
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
rm -f install.sh #use noah to exclude everything except .git
rm -f ethgas
rm -f gas-pump.svg
rm -f gas-pump-symbolic.svg
rm -f .gitmeta
rm -f 'SRC At ETH💎💌.txt'
cd "$SCRIPTPATH"

$maysudo apt --fix-broken install
