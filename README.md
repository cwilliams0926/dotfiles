# dotfiles

My collection of configurations and such I use for coding. Not extremely pretty
or anything. Just what I use to get stuff done. A lot of inspiration was taken from
other dotfiles I've seen however everything is custom.

## Requirements

- Goes without saying, but GNU Stow is required, along
  with the applications being configured
- Obviously, there is no configured display manager, you have to
  handle that yourself
- There are a few manual changes that you cannot do by running Stow
  on directories (some tmux theming and zsh plugins, to name a few), these
  changes can be found in manual-changes.md

## Installation

Meant to be installed using GNU Stow (the directories are designed this way)
however you could easily copy any individual configuration directory here and
place it on your machine.

## TO-DO

- Configure swaync
- Add theme switching script
