import QtQuick
import Quickshell
import Quickshell.Io
import ".."

Item {
  id: root
  implicitWidth: 24
  implicitHeight: 18

  property string connectionType: ""
  property int wifiSignal: 0

  // 0 = offline, 1-3 = wifi signal tiers, 4 = wired (always full)
  readonly property int tier: {
    if (connectionType === "ethernet")
      return 4;
    if (connectionType === "wifi") {
      if (wifiSignal >= 75)
        return 3;
      if (wifiSignal >= 40)
        return 2;
      if (wifiSignal > 0)
        return 1;
    }
    return 0;
  }

  // Canvas only redraws when needed to
  onTierChanged: canvas.requestPaint()
  Component.onCompleted: canvas.requestPaint()

  Canvas {
    id: canvas
    anchors.fill: parent

    onPaint: {
      const ctx = getContext("2d");
      ctx.reset();
      ctx.lineCap = "round";

      const cx = width / 2;
      const cy = height - 3;
      const radii = [5, 9, 13];

      for (let i = 0; i < radii.length; i++) {
        const barTier = i + 1;
        const active = root.tier === 4 || root.tier >= barTier;

        ctx.beginPath();
        // Upper arc of a circle: -135deg to -45deg, i.e. the "fan"
        // shape a wifi icon uses, opening upward.
        ctx.arc(cx, cy, radii[i], -Math.PI * 0.75, -Math.PI * 0.25);
        ctx.lineWidth = 2;
        ctx.strokeStyle = active ? Colors.aqua : Colors.grey0;
        ctx.stroke();
      }

      // Base dot — always drawn, colored the same as an active bar
      // when there's any connection at all, grey when fully offline.
      ctx.beginPath();
      ctx.arc(cx, cy, 1.5, 0, Math.PI * 2);
      ctx.fillStyle = root.tier > 0 ? Colors.aqua : Colors.grey0;
      ctx.fill();
    }
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
}
