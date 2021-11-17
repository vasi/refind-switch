# refind-switch: Reboot from Linux into Windows, and back

[Refind](https://www.rodsbooks.com/refind/) lets you choose the OS at boot time. But it can easily take 30s from telling Windows to restart before I get to the Refind chooser, and then I have only a few seconds to choose Linux. It's easy to miss, and demands attention.

It'd be nicer to just say "I'd like to boot into Linux now", and have the computer take care of the rest. That's what this does!

There are some [scripts out there][1] that do similar things, but they only work when Refind has [use_nvram=true](https://www.rodsbooks.com/refind/configfile.html). Newer Refind defaults it to false, so a different mechanism is needed.

[1]: https://gist.github.com/Darkhogg/82a651f40f835196df3b1bd1362f5b8c

# Requirements

You can probably work around any of these that are different, this is all customized for my system.

* Use Refind version 0.11.3 or higher
  * Have NVRAM settings turned off: Set use_nvram=false in your refind.conf, or omit it in Refind 0.13.1 or higher.
  * Have an EFI system partition (ESP) with Refind installed to `/efi/refind`.
  * The ESP should be FAT32, or something else Linux/Windows can write.
  * Your Windows boot entry should have a name starting with "Microsoft EFI Boot"
  * Your Linux boot entry should have a name starting with "boot\vmlinuz"
* In Windows:
  * Don't have any volumes typically mounted on S:
* In Linux:
  * Have polkit and iconv installed.
  * Have Gnome 3 as your desktop environment.

# Installation

## Windows

* Create a shortcut to BootLinux.ps1
* Open the shortcut's properties, and in the Shortcut pane change the Command so it reads `powershell -f C:\path\to\BootLinux.ps1`
* Put the shortcut in `%appdata%\Microsoft\Windows\Start Menu`, so it shows up in your Start menu. Give it a name like "Reboot into Linux"
* To reboot into Linux, just select "Reboot into Linux" from the Start menu.

## Linux

* Change the paths in the included .desktop file so they point to your clone of refind-switch
* Put the .desktop file in `$HOME/.local/share/applications/`
* To reboot into Windows, just select "Reboot into Windows" from the Gnome Activities overview.
