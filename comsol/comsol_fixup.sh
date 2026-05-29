#!/bin/bash

## Set file icon for MPH files and make them open with COMSOL in spite of being a zip file via globs

#### NOTE: Pay attention to where the MPH file icon comes from.
####       I assumed you make a symbolic link from the actual COMSOL install to /usr/sbin or something like it in PATH,
####       this way the script will be version agnostic.
####       Otherwise, run "sudo ln -s /usr/local/comsol50/multiphysics/bin/comsol /usr/sbin/comsol"

echo "<?xml version=\"1.0\"?>
 <mime-info xmlns=\"http://www.freedesktop.org/standards/shared-mime-info\">
   <mime-type type=\"application/comsolmph\">
   <comment>COMSOL MPH File</comment>
   <glob pattern=\"*.mph\"/>
  </mime-type>
 </mime-info>" > /tmp/comsol-mph.xml

sudo echo "[Desktop Entry]
Version=1.0
Type=Application
Name=COMSOL 5.0
Icon=/usr/local/comsol50/multiphysics/data/images/cube_large.png
Exec=comsol_shortcut.sh %u
NoDisplay=false
Categories=Education;Physics;Engineering;
MimeType=application/comsolmph;
StartupNotify=true
Terminal=false" > /usr/share/applications/comsol5.desktop

sudo xdg-mime install --mode system /tmp/comsol-mph.xml
sudo xdg-icon-resource install --mode system --context mimetypes --size 32 /usr/local/comsol50/multiphysics/data/images/cube_large.png application-comsolmph
xdg-mime default comsol5.desktop application/comsolmph
sudo update-mime-database /usr/share/mime

sudo echo "#!/bin/bash
FILE=\$1

if [[ -f \$FILE ]];then
        comsol -open \$FILE &
else
        comsol &
fi

exit 0
