import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import ".."

Item {
  id: root
  implicitWidth: 18
  implicitHeight: 18

  property string connectionType: ""
  property int wifiSignal: 0

  readonly property string iconName: {
    if (connectionType === "ethernet")
      return "network-wired-symbolic";
    if (connectionType === "wifi") {
      if (wifiSignal >= 75)
        return "network-wireless-signal-excellent-symbolic";
      if (wifiSignal >= 50)
        return "network-wireless-signal-good-symbolic";
      if (wifiSignal >= 25)
        return "network-wireless-signal-ok-symbolic";
      return "network-wireless-signal-weak-symbolic";
    }
    return "network-wireless-offline-symbolic";
  }

  Process {
    id: statusProc
    command: ["nmcli", "-t", "-f", "TYPE,STATE", "dev", "status"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: {
        const lines = text.trim().split("\n");
        const connected = lines.find(line => line.endsWith(":connected"));
        if (!connected) {
          root.connectionType = "";
        } else if (connected.startsWith("wifi:")) {
          root.connectionType = "wifi";
          wifiProc.running = true;
        } else {
          root.connectionType = "ethernet";
        }
      }
    }
  }

  Process {
    id: wifiProc
    command: ["nmcli", "-t", "-f", "ACTIVE,SIGNAL", "dev", "wifi"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: {
        const active = text.trim().split("\n").find(line => line.startsWith("yes:"));
        root.wifiSignal = active ? parseInt(active.split(":")[1]) : 0;
      }
    }
  }

  Timer {
    interval: 10000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: statusProc.running = true
  }

  IconImage {
    id: icon
    anchors.fill: parent
    implicitSize: 18
    visible: false
    source: Quickshell.iconPath(root.iconName, true) || Quickshell.iconPath("network-wireless-offline-symbolic")
  }

  MultiEffect {
    anchors.fill: icon
    source: icon
    colorization: 1.0
    colorizationColor: Colors.green
  }
}
