import QtQuick
import Quickshell
import Quickshell.Services.UPower
import ".."

Item {
  id: root
  implicitWidth: 34
  implicitHeight: 16

  readonly property real pct: UPower.displayDevice.percentage * 100
  readonly property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging

  readonly property string fillColor: {
    if (charging)
      return Colors.aqua;
    if (pct <= 15)
      return Colors.red;
    if (pct <= 30)
      return Colors.orange;
    return Colors.aqua;
  }

  // Battery itself
  Rectangle {
    id: body
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width - 3 // leave room for the nub
    height: parent.height
    radius: 4
    color: "transparent"
    border.color: Colors.grey0
    border.width: 1.5

    // The fill of the battery
    Rectangle {
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.leftMargin: 3
      height: parent.height - 6
      width: (parent.width - 6) * (root.pct / 100)
      radius: 1
      color: root.fillColor

      Behavior on width {
        NumberAnimation {
          duration: 400
        }
      }
    }

    Text {
      anchors.centerIn: parent
      text: Math.round(root.pct)
      color: root.pct < 30 ? Colors.grey0 : Colors.bg0
      font.pixelSize: 9
      font.weight: 700
    }
  }

  // The nub
  Rectangle {
    anchors.left: body.right
    anchors.verticalCenter: parent.verticalCenter
    width: 2
    height: parent.height * 0.5
    radius: 1
    color: Colors.grey0
  }
}
