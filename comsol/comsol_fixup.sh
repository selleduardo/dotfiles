#!/bin/bash

############################################################################### 
# COMSOL Linux desktop integration fix 
# 
# This script: 
# - registers .mph MIME type 
# - creates a COMSOL desktop entry 
# - associates .mph files with COMSOL 
# - enables double-click opening of .mph files 
# 
############################################################################### 


############################################################################### 
# CONFIGURATION 
############################################################################### 

COMSOL_BIN="/usr/local/comsol63/multiphysics/bin/glnxa64/comsol" 
COMSOL_ICON="/usr/local/comsol63/multiphysics/bin/glnxa64/comsol.png"

DESKTOP_FILE="/usr/share/applications/comsol-multiphysics-6.3.desktop" 
WRAPPER_SCRIPT="/usr/local/bin/comsol-open"


############################################################################### 
# CHECKS 
############################################################################### 


# if [[ ! -x "$COMSOL_BIN" ]]; then 
#         echo "ERROR: COMSOL executable not found:" 
#         echo " $COMSOL_BIN" 
#         exit 1 
# fi 

# if [[ ! -f "$COMSOL_ICON" ]]; then
#         echo "ERROR: COMSOL icon not found:" 
#         echo " $COMSOL_ICON" 
#         exit 1 
# fi



############################################################################### 
# CREATE MIME TYPE 
###############################################################################

mkdir -p ~/.local/share/mime/packages


echo "<?xml version=\"1.0\"?>
 <mime-info xmlns=\"http://www.freedesktop.org/standards/shared-mime-info\">
   <mime-type type=\"application/comsolmph\">
   <comment>COMSOL MPH File</comment>
   <glob pattern=\"*.mph\"/>
  </mime-type>
 </mime-info>" > ~/.local/share/mime/packages/comsol-mph.xml

echo "Updating MIME database..." 

update-mime-database ~/.local/share/mime
sudo update-mime-database /usr/share/mime

sudo xdg-mime install --mode system ~/.local/share/mime/packages/comsol-mph.xml


############################################################################### 
# CREATE WRAPPER SCRIPT 
###############################################################################


echo "Creating COMSOL launcher wrapper..." 

cat <<EOF | sudo tee "$WRAPPER_SCRIPT" > /dev/null 
#!/usr/bin/env bash 

FILE="\$1" 

if [[ -n "\$FILE" && -f "\$FILE" ]]; then 
        exec "$COMSOL_BIN" -open "\$FILE" 
else 
        exec "$COMSOL_BIN" 
fi 
EOF

sudo chmod +x "$WRAPPER_SCRIPT"


############################################################################### 
# EDIT DESKTOP ENTRY 
###############################################################################

sudo echo "[Desktop Entry]
Name=COMSOL Multiphysics 6.3
GenericName=COMSOL Multiphysics 6.3
Comment=Launch COMSOL Multiphysics 6.3
Exec=$WRAPPER_SCRIPT %f
Icon=$COMSOL_ICON
Terminal=false
Type=Application
MimeType=application/comsolmph;
Categories=Engineering;Science;
StartupNotify=true" > /usr/share/applications/comsol-multiphysics-6.3.desktop


############################################################################### 
# INSTALL MIME ICON 
###############################################################################

echo "Installing MIME icon..."

sudo xdg-icon-resource install --mode system --context mimetypes --size 32 "$COMSOL_ICON" application-comsolmph


############################################################################### 
# ASSOCIATE MIME TYPE 
############################################################################### 

echo "Associating .mph files with COMSOL..."

xdg-mime default comsol-multiphysics-6.3.desktop application/comsolmph


############################################################################### 
# UPDATE DATABASES 
############################################################################### 

echo "Updating desktop databases..."

sudo update-desktop-database 
sudo update-mime-database /usr/share/mime || true 


############################################################################### 
# DONE 
############################################################################### 

echo 
echo "COMSOL desktop integration installed successfully."
echo