#!/bin/sh -e

if [ "$UID" = 0 ]; then
  # Rewrite the file
  prevboot="/boot/efi/EFI/refind/vars/PreviousBoot"
  if [ ! -f "$prevboot" ]; then
    echo "Can't find PreviousBoot file"
    exit 1
  fi

  echo -n "Boot Microsoft EFI Boot" | iconv -t utf16le > "$prevboot"
else
  # Rerun as root, then reboot
  pkexec "$0" && gnome-session-quit --reboot
fi
