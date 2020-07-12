#!/usr/bin/env bash

APPID=org.flatpak.Joplin

set -e

file="Joplin-1.0.227.AppImage"

chmod +x "${file}"

## running an AppImage file with this argument extracts it into a "squashfs-root" subdirectory..
## I'm going to use that and its included chrome-sandbox
./${file} --appimage-extract


SRC="squashfs-root"

mkdir -p /app/share/icons/hicolor/
mkdir -p /app/bin
mkdir -p /app/share/applications
mv -v ${SRC}/usr/share/icons/hicolor/* /app/share/icons/hicolor/.
cp -rav ${SRC}/* /app/bin/.
install -D run.sh /app/bin/run.sh
install -Dm644 ${APPID}.desktop /app/share/applications/${APPID}.desktop

# rename icons
for i in /app/share/icons/hicolor/*/apps/* ; do
  new="$(sed "s+joplin+${APPID}+g" <<<"${i}")"
  mv -v "${i}" "${new}"
done

# >512 too large
rm -rf /app/share/icons/hicolor/1024x1024
