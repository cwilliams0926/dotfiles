import QtQuick
import Quickshell
import "../components"
import ".."

// Content for the "clock" mode.
//
// Layout note: the three regions below (left/clock/right) are each
// anchored independently to `root`, NOT sequenced in a shared Row.
// A Row's "center" is only the true center when both sides are equal
// width — ours aren't (NowPlayingCard vs. two small icons), so a Row
// pushes the clock off-center whenever the sides are asymmetric. This
// is the exact bug you hit with the three test rectangles, just showing
// up again here. Independent anchoring sidesteps it entirely: the clock
// centers on `root` regardless of what either side is doing.
Item {
  id: root

  property bool collapsed: true

  // Fixed constant when expanded, not derived from content anymore.
  // This is what makes positions genuinely fixed — if implicitWidth
  // changed with content (like it did before), everything anchored to
  // it would still shift even with independent anchoring. 560 leaves
  // enough room for NowPlayingCard (170px) on the left and the clock
  // column to not visually touch — tune this by eye once it's running,
  // since exact text widths depend on your font.
  implicitWidth: collapsed ? 150 : 560
  implicitHeight: collapsed ? 34 : 148

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  Text {
    anchors.centerIn: parent
    opacity: root.collapsed ? 1 : 0
    text: Qt.formatDateTime(clock.date, "hh:mm")
    color: Colors.fg
    font {
      pixelSize: 14
      weight: 700
      family: "SF Pro Display"
    }
    Behavior on opacity {
      NumberAnimation {
        duration: 150
      }
    }
  }

  // --- Left: now playing --------------------------------------------
  NowPlayingCard {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 20
    opacity: root.collapsed ? 0 : 1
    Behavior on opacity {
      NumberAnimation {
        duration: 200
      }
    }
  }

  // --- Center: clock — anchored to root directly, not to siblings ---
  Column {
    anchors.centerIn: parent
    spacing: 2
    opacity: root.collapsed ? 0 : 1
    Behavior on opacity {
      NumberAnimation {
        duration: 200
        easing.type: Easing.Bezier
        easing.bezierCurve: [0.34, 0.8, 0.34, 1, 1, 1]
      }
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: Qt.formatDateTime(clock.date, "hh:mm")
      color: Colors.fg
      font {
        pixelSize: 26
        weight: 700
        family: "SF Pro Display"
      }
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: Qt.formatDateTime(clock.date, "dddd, MMMM d")
      color: Colors.grey2
      font.pixelSize: 13
      font.family: "SF Pro Display"
    }
  }

  // --- Right: battery + network, in a pill-shaped container ----------
  Rectangle {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 20
    opacity: root.collapsed ? 0 : 1
    Behavior on opacity {
      NumberAnimation {
        duration: 200
      }
    }

    color: Colors.bg2
    border.color: Colors.grey0
    border.width: 1
    radius: height / 2

    // Size this container from its own Row's content instead of a fixed
    // number — same "ask the child, don't guess" pattern as before, just
    // applied to a background shape instead of the whole pill.
    implicitWidth: statusRow.implicitWidth + 20
    implicitHeight: statusRow.implicitHeight + 12

    Row {
      id: statusRow
      anchors.centerIn: parent
      spacing: 10

      BatteryIndicator {}
      NetworkIndicator {}
    }
  }
}
