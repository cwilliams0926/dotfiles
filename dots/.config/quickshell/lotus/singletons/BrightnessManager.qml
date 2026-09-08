pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
  id: root

  property real brightness: 0
  property bool ready: false

  function refresh() {
    brightnessProcess.running = true;
  }

  Process {
    id: brightnessProcess

    command: ["brightnessctl", "-m"]

    stdout: StdioCollector {
      onStreamFinished: {
        const parts = text.trim().split(",");

        if (parts.length >= 4) {
          // brightnessctl -m gives percentage like "50%"
          const percent = parseFloat(parts[3]);

          if (!isNaN(percent)) {
            root.brightness = percent / 100.0;
          }
        }

        root.ready = true;
      }
    }
  }

  Component.onCompleted: refresh()
}
