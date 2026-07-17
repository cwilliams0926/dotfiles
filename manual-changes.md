# Manual Changes

This file contains configurations that require manual changes
and cannot be stowed.

## TMUX

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
