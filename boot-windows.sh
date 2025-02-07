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
  case "$XDG_CURRENT_DESKTOP" in
    Gnome) quit_cmd="gnome-session-quit --reboot" ;;
    *Cinnamon) quit_cmd="cinnamon-session-quit --reboot" ;;
    KDE) quit_cmd="qdbus org.kde.Shutdown /Shutdown logoutAndReboot" ;;
    *) echo "Don't know how to restart"; exit -1 ;;
  esac

  # Rerun as root, then reboot
  pkexec "$0" && $quit_cmd
fi
