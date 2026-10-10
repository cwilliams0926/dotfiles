import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs

Item {
  id: root
  implicitWidth: 34
  implicitHeight: 16

  readonly property real pct: UPower.displayDevice.percentage * 100
  readonly property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging

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
      color: Colors.aqua

      Behavior on width {
        NumberAnimation {
          duration: 400
        }
      }
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
