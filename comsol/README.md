# Vendored COMSOL Linux Fix Script

This directory contains a vendored third-party script used to improve
COMSOL compatibility and behavior on Linux systems.

## Origin

Source repository:

https://github.com/atomspring/COMSOL_Linux_Improvements

Original file:

comsol_fixup.sh

## Updating

To update the vendored version:

```bash
curl -L \
  https://raw.githubusercontent.com/atomspring/COMSOL_Linux_Improvements/master/comsol_fixup.sh \
  -o comsol/comsol_fixup.sh
```