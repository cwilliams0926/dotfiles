import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs

Item {
  id: root

  property bool collapsed: true

  implicitWidth: collapsed ? 232 : 572
  implicitHeight: collapsed ? 34 : 84

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  RowLayout {
    anchors.centerIn: parent
    spacing: 28
    opacity: root.collapsed ? 1 : 0
    Behavior on opacity {
      NumberAnimation {
        duration: 150
      }
    }

    Workspaces {
      Layout.alignment: Qt.AlignVCenter
    }

    RowLayout {
      spacing: 4
      Layout.alignment: Qt.AlignVCenter

      Text {
        id: clockText
        text: Qt.formatDateTime(clock.date, "hh:mm")
        color: Colors.fg
        font {
          pixelSize: 15
          weight: 700
          family: "SF Mono"
          letterSpacing: -1
        }
      }
    }

    RowLayout {
      spacing: 4
      Layout.alignment: Qt.AlignVCenter

      Item {
        Layout.preferredWidth: net.implicitWidth * 0.7
        Layout.preferredHeight: net.implicitHeight * 0.7
        NetworkIndicator {
          id: net
          scale: 0.7
          transformOrigin: Item.TopLeft
        }
      }
      Item {
        Layout.preferredWidth: battery.implicitWidth * 0.7
        Layout.preferredHeight: battery.implicitHeight * 0.7
        BatteryIndicator {
          id: battery
          scale: 0.7
          transformOrigin: Item.TopLeft
        }
      }
    }
  }

  Item {
    anchors.centerIn: parent
    implicitWidth: 572
    implicitHeight: 84

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

        NetworkIndicator {}
        BatteryIndicator {}
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
}
