import QtQuick
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

    Island {
      id: island
    }
  }
}
