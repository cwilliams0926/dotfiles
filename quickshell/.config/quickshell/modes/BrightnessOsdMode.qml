import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs
import qs.singletons

Item {
  id: root

  implicitWidth: 200
  implicitHeight: 34

  RowLayout {
    anchors.fill: parent
    anchors.leftMargin: 12
    anchors.rightMargin: 12
    spacing: 6
    Text {
      text: "brightness_7"
      color: Colors.yellow
      font.pixelSize: 16
      font.family: "Material Symbols Rounded"
    }
    Rectangle {
      Layout.fillWidth: true
      implicitHeight: 6
      radius: height / 2
      color: Colors.bg0

      Rectangle {
        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }
        implicitWidth: parent.width * (BrightnessManager.brightness ?? 0)
        radius: parent.radius
        color: Colors.yellow

        Behavior on implicitWidth {
          NumberAnimation {
            duration: 100
          }
        }
      }
    }
  }
}
