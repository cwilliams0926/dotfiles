# Manual Changes

This file contains configurations that require manual changes
and cannot be stowed. This is because I'm too lazy to write a script.

## zsh

In order for my zsh configuration to work, you need to put
the following plugins into a plugins/ directory inside of
zsh/.config/zsh/

- [fzf-tab](https://github.com/aloxaf/fzf-tab)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## custom_scripts

For the wlsunset and battery-monitor scripts, the notify-send lines use the -i (icon) tags
with an absolute path to ~/.config/swaync/icons/, however they don't use the ~ and instead
use /home/user/... To fix this, you have to manually change those lines to include your
username instead of mine, otherwise there will be no icon.

## systemd

The systemd services need to be enabled using --user to be used. The scripts for weather and
battery both rely on these services to function.

## Hyprglass

The decoration picker includes a hyprglass toggle, you need to install hyprglass to use this.
