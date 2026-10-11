import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs

Item {
  id: root

  property bool collapsed: true

  implicitWidth: collapsed ? 232 : 572
  implicitHeight: collapsed ? 34 : 64

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
          family: "SF Pro Display"
        }
      }
    }

    RowLayout {
      spacing: 4
      Layout.alignment: Qt.AlignVCenter

      NetworkIndicator {
        maxHeight: 10
        minHeight: 3
        barWidth: 2.5
        barSpacing: 1.5
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

    // Left: Workspaces and App
    Column {
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.leftMargin: 28
      opacity: root.collapsed ? 0 : 1
      spacing: 6
      Behavior on opacity {
        NumberAnimation {
          duration: 200
        }
      }
      ActiveApp {}
      Workspaces {}
    }

    // Right: Battery and Network
    Column {
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      anchors.rightMargin: 28
      opacity: root.collapsed ? 0 : 1
      spacing: 6
      Behavior on opacity {
        NumberAnimation {
          duration: 200
        }
      }

      NotificationIndicator {
        anchors.right: parent.right
      }
      Row {
        id: statusRow
        anchors.right: parent.right
        spacing: 10

        NetworkIndicator {}
        BatteryIndicator {}
      }
    }
  }

  // Middle: Clock
  Row {
    anchors.centerIn: parent
    spacing: 6
    opacity: root.collapsed ? 0 : 1
    Behavior on opacity {
      NumberAnimation {
        duration: 200
        easing.type: Easing.Bezier
        easing.bezierCurve: [0.34, 0.8, 0.34, 1, 1, 1]
      }
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: Qt.formatDateTime(clock.date, "hh:mm")
      color: Colors.fg
      font {
        pixelSize: 24
        weight: 700
        family: "SF Pro Display"
      }
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: Qt.formatDateTime(clock.date, "ddd, MMM d")
      color: Colors.grey2
      font.pixelSize: 13
      font.family: "SF Pro Display"
    }
  }
}
