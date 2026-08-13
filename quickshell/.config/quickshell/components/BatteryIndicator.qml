import QtQuick
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Widgets
import ".."

// Same "self-contained, reports its own size, nobody outside needs to know
// the internals" rule as modes/ — just one level smaller in scope. Nothing
// using <BatteryIndicator> needs to know UPower exists.
Item {
  id: root
  implicitWidth: 18
  implicitHeight: 18

  readonly property real pct: UPower.displayDevice.percentage * 100
  readonly property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging

  // Icon themes ship battery icons at fixed steps (000/010/020.../100), not
  // one for every possible percentage. Round to the nearest 10 so we always
  // land on a name that actually exists rather than guessing an exact one.
  readonly property string bucket: {
    const step = Math.max(0, Math.min(100, Math.round(pct / 10) * 10));
    return String(step).padStart(3, "0");
  }
  readonly property string iconName: "battery-" + bucket + (charging ? "-charging" : "") + "-symbolic"

  IconImage {
    anchors.fill: parent
    implicitSize: 18
    // Quickshell.iconPath(name, true) returns "" if that exact name isn't
    // in your icon theme instead of showing a broken-image glyph. The ||
    // falls back to a near-universal name so you always see *something*
    // sensible even if your theme doesn't have fine-grained battery steps.
    source: Quickshell.iconPath(root.iconName, true) || Quickshell.iconPath("battery-full-symbolic")
  }
}
