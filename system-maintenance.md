# System Maintenance

_Perform once monthly_
Steps obtained from ![this article](https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/)

## System update/upgrade

Check Arch Linux latest news ![here](https://archlinux.org/)
Perform by running:
`$ sudo pacman -Syu`
or for yay:
`$ yay -Syu`

## Clean pacman cache

Run to clean everything and keep latest 3 versions:
`$ sudo paccache -r`

## Remove orphan packages

Check to see any orphan packages:
`$ sudo pacman -Qdtq`
Remove all orphans with this command:
`sudo pacman -Qtdq | sudo pacman -Rns -`

## Remove unwanted packages

List all installed packages to check for unused packages:
`$ pacman -Qei | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h`
Can also list ones installed from AUR:
`$ pacman -Qim | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h`
This command uninstalls all unneeded packages and their unused
dependencies and configuration files:
`$ sudo pacman -Rns $(pacman -Qdtq)`
If we want to uninstall individual packages:
`$ sudo pacman -Rns <package-name>`

## Clean /home directory cache

Check cache size:
`$ sudo du -sh ~/.cache`
Run to clear it up:
`$ rm -rf ~/.cache/*`

## Clean system logs

Perform a system check to see how much space is being used by logs
`$ journalctl --disk-usage`
Remove logs based on time:
`$ sudo journalctl --vacuum-time=7d`

# Last Update 08-09-2026
