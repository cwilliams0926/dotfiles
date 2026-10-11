import QtQuick
import Quickshell
import qs.components
import qs

Item {
  id: root

  property bool collapsed: true

  implicitWidth: collapsed ? 232 : 572
  implicitHeight: collapsed ? 34 : 64

  // 0 = collapsed, 1 = expanded
  property real t: collapsed ? 0 : 1
  Behavior on t {
    SpringAnimation {
      spring: 5.0
      damping: 0.34
      mass: 0.7
      epsilon: 0.002   // t is 0..1, so epsilon must be tiny (0.25 would snap instantly)
    }
  }

  // spring can overshoot, so clamp for opacity
  readonly property real fade: Math.max(0, Math.min(1, t))

  function lerp(a, b) {
    return a + (b - a) * t;
  }

  // Everything is positioned relative to the CENTER, so it doesn't matter
  // that root.width jumps to its final value while the island springs.
  readonly property real cx: width / 2
  readonly property real cy: height / 2

  // layout constants
  readonly property real edge: 286 - 28     // expanded: 572/2 - margin
  readonly property real gap: 28            // collapsed row spacing
  readonly property real clockScale: 24 / 15
  readonly property real statusScaleCollapsed: 0.7

  // collapsed row geometry (centered group of ws | clock | status)
  readonly property real statusCollW: status.width * statusScaleCollapsed
  readonly property real collTotal: ws.width + gap + clockText.width + gap + statusCollW
  readonly property real collLeft: -collTotal / 2

  // expanded clock + date geometry
  readonly property real clockExpW: clockText.width * clockScale
  readonly property real expTotal: clockExpW + 6 + dateText.width
  readonly property real expLeft: -expTotal / 2

  // expanded column heights
  readonly property real leftColH: activeApp.height + 6 + ws.height
  readonly property real rightColH: notif.height + 6 + status.height

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  // ---- Workspaces (shared) ----
  Workspaces {
    id: ws
    x: root.cx + root.lerp(root.collLeft, -root.edge)
    y: root.cy + root.lerp(0, -root.leftColH / 2 + activeApp.height + 6 + ws.height / 2) - height / 2
  }

  // ---- Clock (shared; scaled instead of animating pixelSize) ----
  Text {
    id: clockText
    text: Qt.formatDateTime(clock.date, "hh:mm")
    color: Colors.fg
    font {
      pixelSize: 15
      weight: 700
      family: "SF Pro Display"
    }
    scale: root.lerp(1, root.clockScale)
    transformOrigin: Item.Center

    x: root.cx + root.lerp(root.collLeft + ws.width + root.gap + width / 2, root.expLeft + root.clockExpW / 2) - width / 2
    y: root.cy - height / 2
  }

  // ---- Status: network + battery (shared; scaled) ----
  Row {
    id: status
    spacing: 10
    scale: root.lerp(root.statusScaleCollapsed, 1)
    transformOrigin: Item.Center

    NetworkIndicator {}
    BatteryIndicator {}

    x: root.cx + root.lerp(root.collLeft + root.collTotal - root.statusCollW / 2, root.edge - width / 2) - width / 2
    y: root.cy + root.lerp(0, -root.rightColH / 2 + notif.height + 6 + height / 2) - height / 2
  }

  // ---- Expanded-only elements (fade in) ----
  ActiveApp {
    id: activeApp
    opacity: root.fade
    x: root.cx - root.edge
    y: root.cy - root.leftColH / 2
  }

  NotificationIndicator {
    id: notif
    opacity: root.fade
    x: root.cx + root.edge - width
    y: root.cy - root.rightColH / 2
  }

  Text {
    id: dateText
    text: Qt.formatDateTime(clock.date, "ddd, MMM d")
    color: Colors.grey2
    font.pixelSize: 13
    font.family: "SF Pro Display"
    opacity: root.fade
    x: root.cx + root.expLeft + root.clockExpW + 6
    y: root.cy - height / 2
  }
}
