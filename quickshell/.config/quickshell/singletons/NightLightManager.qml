pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
  id: root

  property bool on: false

  function setOn(state: bool): void {
    root.on = state;
  }

  property Process initialCheck: Process {
    command: ["pidof", "wlsunset"]
    running: true

    onExited: exitCode => {
      root.on = (exitCode === 0);
    }
  }
}
