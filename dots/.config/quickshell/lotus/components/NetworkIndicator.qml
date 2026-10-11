import QtQuick
import Quickshell
import Quickshell.Io
import qs

Item {
  id: root

  property string connectionType: ""
  property int wifiSignal: 0

  property int barCount: 4
  property real barWidth: 3
  property real barSpacing: 2
  property real maxHeight: 14
  property real minHeight: 4

  implicitWidth: barCount * barWidth + (barCount - 1) * barSpacing
  implicitHeight: maxHeight

  // 0 = offline, 1-4 = filled bars (ethernet is always full)
  readonly property int bars: {
    if (connectionType === "ethernet")
      return 4;
    if (connectionType === "wifi") {
      if (wifiSignal >= 75)
        return 4;
      if (wifiSignal >= 50)
        return 3;
      if (wifiSignal >= 25)
        return 2;
      if (wifiSignal > 0)
        return 1;
    }
    return 0;
  }

  Row {
    spacing: root.barSpacing

    Repeater {
      model: root.barCount

      // Fixed-height wrapper: Row positions this, the bar anchors to its bottom
      delegate: Item {
        required property int index

        width: root.barWidth
        height: root.maxHeight

        Rectangle {
          anchors.bottom: parent.bottom
          width: parent.width
          height: root.minHeight + (root.maxHeight - root.minHeight) * index / (root.barCount - 1)
          radius: width / 2
          color: index < root.bars ? Colors.aqua : Colors.bg4

          Behavior on color {
            ColorAnimation {
              duration: 150
            }
          }
        }
      }
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
