import QtQuick
import Quickshell
import ".."

// Content for the "clock" mode. This is what the pill's Loader swaps in.
// It exposes `collapsed` so the parent Island can drive size + hover expansion,
// but the important teaching point is: THIS FILE decides its own size.
// Island.qml never needs to know "clock mode is 150x34 or 340x120" — it just
// asks this component for its implicitWidth/implicitHeight.
Item {
  id: root

  // Island sets this. When true we show the small centered time.
  // When false, we show the big time + date.
  property bool collapsed: true

  implicitWidth: collapsed ? 150 : 340
  implicitHeight: collapsed ? 34 : 120

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
}
