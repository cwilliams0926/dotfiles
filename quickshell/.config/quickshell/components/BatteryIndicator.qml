import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Widgets
import ".."

Item {
  id: root
  implicitWidth: 18
  implicitHeight: 18

  readonly property real pct: UPower.displayDevice.percentage * 100
  readonly property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging

  readonly property string bucket: {
    const step = Math.max(0, Math.min(100, Math.round(pct / 10) * 10));
    return String(step).padStart(3, "0");
  }
  readonly property string iconName: "battery-" + bucket + (charging ? "-charging" : "") + "-symbolic"

  // The raw icon — kept invisible. MultiEffect reads its pixels as a
  // source and draws the colorized result; the original stays hidden
  // so you don't see two overlapping copies.
  IconImage {
    id: icon
    anchors.fill: parent
    implicitSize: 18
    visible: false
    source: Quickshell.iconPath(root.iconName, true) || Quickshell.iconPath("battery-full-symbolic")
  }

  MultiEffect {
    anchors.fill: icon
    source: icon
    colorization: 1.0
    colorizationColor: Colors.green
  }
}
