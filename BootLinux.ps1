# Mount EFI system partition
if (-not (Test-Path S:)) {
    mountvol S: /S
}

# Strings I've seen:
# Boot Microsoft EFI boot from EFI system partition
# Boot boot\vmlinuz-5.10-x86_64 from root  

# Set to boot string + space + null byte. Or just a prefix
$os = "Boot boot\vmlinuz"
# Write as UTF16-LE without BOM
$bytes = [system.Text.Encoding]::Unicode.GetBytes($os)
# Can't use Set-Content on arbitrary filesystem
[io.file]::WriteAllBytes("S:\EFI\refind\vars\PreviousBoot", $bytes)

# Restart
shutdown /t 0 /r
