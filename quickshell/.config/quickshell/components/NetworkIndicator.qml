import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import ".."

// No Quickshell service exists for network state (unlike battery/media),
// so this wraps the same Process + StdioCollector + Timer polling pattern
// from ClockMode's first draft — just packaged behind a component so
// nothing outside this file needs to know nmcli is involved.
Item {
  id: root
  implicitWidth: 18
  implicitHeight: 18

  property string connectionType: "" // "wifi" | "ethernet" | "" (offline)
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

  // Step 1: what's connected right now, and what kind is it?
  // `nmcli -t -f TYPE,STATE dev status` prints one line per device, e.g.
  // "wifi:connected" or "ethernet:disconnected".
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
          wifiProc.running = true; // wifi needs a second call for signal %
        } else {
          root.connectionType = "ethernet";
        }
      }
    }
  }

  // Step 2: only runs once we know we're actually on wifi. This is the
  // "chain a second process off the result of the first" pattern — the
  // same idea as the Mpris active-player search, just async instead of
  // a synchronous loop.
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
    anchors.fill: parent
    implicitSize: 18
    source: Quickshell.iconPath(root.iconName, true) || Quickshell.iconPath("network-wireless-offline-symbolic")
  }
}
