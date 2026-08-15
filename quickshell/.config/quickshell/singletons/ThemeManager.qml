pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
  readonly property string themeScript: Quickshell.env("HOME") + "/.config/custom_scripts/set-theme"
  readonly property string currentTheme: currentThemeFile.text().trim()

  FileView {
    id: currentThemeFile
    path: Quickshell.env("HOME") + "/.config/current-theme"
    watchChanges: true
    onFileChanged: reload()
  }

  Process {
    id: themeProcess

    stdinEnabled: false
  }

  function applyTheme(name) {
    if (themeProcess.running) {
      console.warn("Theme switch already running");
      return;
    }

    themeProcess.command = [themeScript, name];
    themeProcess.running = true;
  }
}
