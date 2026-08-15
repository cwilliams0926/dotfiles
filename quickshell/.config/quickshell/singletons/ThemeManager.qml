pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
  readonly property string themeScript: Quickshell.env("HOME") + "/.config/custom_scripts/set-theme"

  Process {
    id: themeProcess

    stdinEnabled: false

    stdout: StdioCollector {
      onStreamFinished: console.log("Theme stdout:", text)
    }

    stderr: StdioCollector {
      onStreamFinished: console.log("Theme stderr:", text)
    }
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
