#!/bin/sh -e

refind_vars="/boot/efi/EFI/refind/vars"
if [ -w "$refind_vars" ]; then
  # Rewrite the file
  prevboot="$refind_vars/PreviousBoot"
  echo -n "Boot Microsoft EFI Boot" | iconv -t utf16le > "$prevboot"
elif [ $(id -u) = 0 ]; then
  # Already root, maybe there's no refind?
  echo "No refind vars found"
  exit -1
else
  # Rerun as root, then reboot
  pkexec "$0" && gnome-session-quit --reboot
fi
