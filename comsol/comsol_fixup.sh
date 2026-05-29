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
Name=COMSOL Multiphysics 6.3
GenericName=COMSOL Multiphysics 6.3
Comment=Launch COMSOL Multiphysics 6.3
Exec=/usr/local/comsol63/multiphysics/bin/glnxa64/comsol %F
Icon=/usr/local/comsol63/multiphysics/bin/glnxa64/comsol.png
Terminal=false
Type=Application
MimeType=application/comsolmph;
Categories=Engineering;Science;
StartupNotify=true" > /usr/share/applications/comsol-multiphysics-6.3.desktop

sudo xdg-mime install --mode system /tmp/comsol-mph.xml
sudo xdg-icon-resource install --mode system --context mimetypes --size 32 /usr/local/comsol63/multiphysics/bin/glnxa64/comsol.png application-comsolmph
xdg-mime default comsol-multiphysics-6.3.desktop application/comsolmph
sudo update-mime-database /usr/share/mime

sudo echo "#!/bin/bash
FILE=\$1

if [[ -f \$FILE ]];then
        comsol -open \$FILE &
else
        comsol &
fi

exit 0
