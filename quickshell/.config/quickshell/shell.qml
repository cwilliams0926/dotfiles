//@ pragma IconTheme Papirus

import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.components
import qs.singletons

ShellRoot {
  PanelWindow {
    anchors {
      top: true
      left: true
      right: true
    }
    exclusiveZone: 38
    implicitHeight: 360
    color: "transparent"

    WlrLayershell.keyboardFocus: island.mode === "launcher" ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    Component.onCompleted: {
      console.log("touching notification manager:", NotificationManager.activeNotification);
    }

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

  ScreenCorners {}
}
