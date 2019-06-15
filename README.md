# Arch Installer

My installation-scripts for [Arch Linux](https://www.archlinux.org/).
Currently those scripts are just templates for manual installation and are not intended to run on their own.

- **OS:** Arch Linux
- **Bootloader:** systemd-boot
- **DE:** Cinnamon
- **Encryption:** LUKS encryption of the root-partition via dm-encrypt/cryptsetup.
For decryption an USB-stick with the key needs to be plugged in during bootup.

**WARNING: Always make a backup of the key-file and have at least a second USB-Key just in case you lose or break your USB-Key!
Otherwise, you will lock yourself out of your computer.
You will never be able to recover your data!**
