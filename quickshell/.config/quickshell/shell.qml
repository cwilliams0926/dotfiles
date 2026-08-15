//@ pragma IconTheme Papirus

import QtQuick
import QtQuick.Effects
import Quickshell

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }
  exclusiveZone: 38
  implicitHeight: 360
  color: "transparent"
  mask: Region {
    item: island
  }
  focusable: true

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
