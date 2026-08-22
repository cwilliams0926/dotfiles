import QtQuick
import Quickshell
import qs
import qs.singletons

Item {
  id: root

  implicitWidth: 150
  implicitHeight: 34

  Text {
    anchors.centerIn: parent
    text: NightLightManager.on ? "  Night Light" : "󰖙  Night Light Off"
    color: Colors.fg
    font {
      pixelSize: 14
      weight: 700
      family: "SF Pro Display"
    }

    scale: 0.6
    opacity: 0
    transformOrigin: Item.Center

    Component.onCompleted: {
      scale = 1;
      opacity = 1;
    }

    Behavior on scale {
      SpringAnimation {
        spring: 5
        damping: 0.5
        mass: 1
      }
    }

    Behavior on opacity {
      NumberAnimation {
        duration: 180
      }
    }
  }
}
