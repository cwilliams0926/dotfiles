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
  }
}
