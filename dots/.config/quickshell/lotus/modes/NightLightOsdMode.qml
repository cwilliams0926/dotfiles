import QtQuick
import Quickshell
import qs
import qs.singletons

Item {
  id: root
  implicitWidth: 150
  implicitHeight: 34

  Row {
    anchors.centerIn: parent
    spacing: 6
    scale: 0.6
    opacity: 0
    transformOrigin: Item.Center

    Text {
      text: NightLightManager.on ? "bedtime" : "bedtime_off"
      color: Colors.fg
      anchors.verticalCenter: parent.verticalCenter
      font {
        pixelSize: 18
        family: "Material Symbols Rounded"
      }
      renderType: Text.QtRendering
    }

    Text {
      text: NightLightManager.on ? "Night Light" : "Night Light Off"
      color: Colors.fg
      anchors.verticalCenter: parent.verticalCenter
      font {
        pixelSize: 14
        weight: 700
        family: "SF Pro Display"
      }
    }

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
