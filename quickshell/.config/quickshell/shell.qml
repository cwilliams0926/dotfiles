import QtQuick
import QtQuick.Effects
import Quickshell

ShellRoot {
  PanelWindow {
    anchors {
      top: true
      left: true
      right: true
    }
    exclusiveZone: 38
    implicitHeight: 160
    color: "transparent"
    mask: Region {
      item: island
    }

    RectangularShadow {
      anchors.fill: island
      radius: island.radius
      blur: 20
      spread: 2
      color: Qt.rgba(0, 0, 0, 0.4)
    }

    Island {
      id: island
    }
  }
}
