import QtQuick
import Quickshell
import qs.components
import qs

Item {
  id: root

  property bool collapsed: true

  implicitWidth: collapsed ? 150 : 572
  implicitHeight: collapsed ? 34 : 84

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
      pixelSize: 15
      weight: 700
      family: "SF Mono"
      letterSpacing: -1
    }
    Behavior on opacity {
      NumberAnimation {
        duration: 150
      }
    }
  }

  // Left: Now Playing
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

  // Middle: Clock
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
        family: "SF Mono"
        letterSpacing: -1
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

  // Right: Battery and Network
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
    HoverHandler {
      id: hover
      cursorShape: Qt.PointingHandCursor
    }

    color: Colors.bg0
    radius: height / 3
    border.width: hover.hovered ? 1 : 0
    border.color: hover.hovered ? Colors.aqua : Colors.bg0

    implicitWidth: statusRow.implicitWidth + 32
    implicitHeight: statusRow.implicitHeight + 20

    Row {
      id: statusRow
      anchors.centerIn: parent
      spacing: 14

      BatteryIndicator {}
      NetworkIndicator {}
    }
  }
}
