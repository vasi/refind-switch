#!/bin/sh -e

if [ -d "/efi" ]; then
  esp="/efi"
elif [ -d "/boot/efi" ]; then
  esp="/boot/efi"
fi
if [ -z "$esp" ]; then
  echo "No ESP found"
  exit -1
fi

refind_vars="$esp/EFI/refind/vars"
if [ -w "$refind_vars" ]; then
  # Rewrite the file
  prevboot="$refind_vars/PreviousBoot"
  echo -n "Boot Microsoft EFI Boot" | iconv -t utf16le > "$prevboot"
elif [ $(id -u) = 0 ]; then
  # Already root, maybe there's no refind?
  echo "No refind vars found"
  exit -1
else
  quit_cmd="gnome-session-quit --reboot"
  if [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
    quit_cmd="qdbus org.kde.Shutdown /Shutdown logoutAndReboot"
  fi
  
  # Rerun as root, then reboot
  pkexec "$0" && $quit_cmd
fi
