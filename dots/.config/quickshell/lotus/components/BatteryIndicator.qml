import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs

Item {
  id: root
  implicitWidth: 30
  implicitHeight: 14

  readonly property real pct: UPower.displayDevice.percentage * 100
  readonly property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging

  Rectangle {
    id: body
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width - 3 // leave room for the nub
    height: parent.height
    radius: height * 0.25
    color: Colors.bg4

    // The fill of the battery
    Rectangle {
      anchors.left: parent.left
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      radius: body.radius
      color: Colors.aqua
      visible: root.pct > 0

      // Never narrower than two radii, so the rounded ends don't collapse
      width: Math.max(body.radius * 2, body.width * (root.pct / 100))

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
    color: root.pct >= 99 ? Colors.aqua : Colors.bg4
  }
}
