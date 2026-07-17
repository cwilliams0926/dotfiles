# Manual Changes

This file contains configurations that require manual changes
and cannot be stowed. This is because I'm too lazy to write a script.

## tmux

For the gruvbox theme, stow the tmux-gruvbox directory, and
then do the following changes in the plugin's directory:

In gruvbox.tmux, under build_status_module() {}:

```
-    local show_icon="#[fg=$thm_bg,bg=$color,nobold,nounderscore,noitalics]$icon "
+    local show_icon="#[fg=$thm_contrast,bg=$color,nobold,nounderscore,noitalics]$icon "
```

In window/window_current_format.sh:

```
-  local background="$thm_bg"
+  local background="$thm_contrast"
```

## zsh

In order for my zsh configuration to work, you need to put
the following plugins into a plugins/ directory inside of
zsh/.config/zsh/

- [fzf-tab](https://github.com/aloxaf/fzf-tab)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
