# init.lua
My simple neovim config. Very minimal. I'm a beginner.

## Pre-req
Install [ripgrep](https://github.com/BurntSushi/ripgrep)

## Remaps
| Mode | Key | Action |
| --- | --- | --- |
| `n` | `<leader>pv` | Open netrw (`:Ex`) |
| `v` | `J` | Move selection down |
| `v` | `K` | Move selection up |
| `n` | `J` | Join lines without cursor moving |
| `n` | `<C-d>` | Move down half a screen with cursor centered |
| `n` | `<C-u>` | Move up half a screen with cursor centered |
| `n` | `n` | Search forward cleanly |
| `n` | `N` | Search backward cleanly |
| `n` | `<leader>p` | Paste without losing yank |
| `n` | `<leader>y` | Yank to system clipboard |
| `v` | `<leader>y` | Yank to system clipboard (visual) |
| `n` | `<leader>Y` | Yank to system clipboard (line) |
| `n` | `Q` | Unmapped |

## Telescope Keymaps
| Mode | Key | Action |
| --- | --- | --- |
| `n` | `<leader>pf` | Find files |
| `n` | `<leader>ps` | Live grep |
| `n` | `<C-p>` | Find git-tracked files |

## LSP Keymaps
| Mode | Key | Action |
| --- | --- | --- |
| `n` | `K` | Hover information |
| `n` | `gd` | Go-to definition |
| `n` | `<leader>ca | Code Action |
| `n` | `<leader>rn | Rename |

## Harpoon Keymaps
| Mode | Key | Action |
| --- | --- | --- |
| `n` | `<leader>a` | Add file to Harpoon |
| `n` | `<C-e>` | Open Harpoon menu |
| `n` | `<C-h>` | File 1 |
| `n` | `<C-j>` | File 2 |
| `n` | `<C-k>` | File 3 |
| `n` | `<C-l>` | File 4 |
| `n` | `<C-S-P>` | Previous file |
| `n` | `<C-S-N>` | Next file |

## Live Server Keymaps
| Mode | Key | Action |
| --- | --- | --- |
| `n` | `<leader>ls` | Start live server |
| `n` | `<leader>lx` | Stop live server |
