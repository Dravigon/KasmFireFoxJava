#!/bin/bash

# 1. Create .desktop file
cat > ~/.local/share/applications/javaws.desktop <<EOF
[Desktop Entry]
Name=Java Web Start
Exec=/bin/javaws %u
MimeType=application/x-java-jnlp-file;
Icon=java
Type=Application
Terminal=false
Categories=Network;
NoDisplay=true
EOF

# 2. Create a MIME type entry for JNLP if not already defined
mkdir -p ~/.local/share/mime/packages
cat > ~/.local/share/mime/packages/x-java-jnlp-file.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="application/x-java-jnlp-file">
    <comment>Java Web Start</comment>
    <glob pattern="*.jnlp"/>
  </mime-type>
</mime-info>
EOF

# 3. Update MIME database
update-mime-database ~/.local/share/mime

# 4. Associate MIME type with javaws.desktop
xdg-mime default javaws.desktop application/x-java-jnlp-file

# 5. Update desktop database
update-desktop-database ~/.local/share/applications

echo "JNLP file association completed: *.jnlp → /bin/javaws"
