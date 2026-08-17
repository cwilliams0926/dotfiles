pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
  Process {
    id: powerProcess
    stdinEnabled: true
  }

  function runAction(command) {
    if (powerProcess.running) {
      console.warn("Power action already running");
      return;
    }
    powerProcess.command = command;
    powerProcess.running = true;
  }
}
