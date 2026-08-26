import QtQuick
import qs

Item {
  id: root

  property var notif: null
  property real size: 48
  property color fallbackColor: Colors.aqua

  implicitWidth: size
  implicitHeight: size

  Rectangle {
    id: iconFrame
    anchors.fill: parent
    radius: width / 2
    color: root.fallbackColor
    clip: true

    Image {
      id: iconImage
      anchors.fill: parent
      visible: root.notif !== null && status === Image.Ready
      source: root.notif?.appIcon || ""
      fillMode: Image.PreserveAspectCrop
      asynchronous: true
    }

    Text {
      anchors.centerIn: parent
      visible: !iconImage.visible
      text: {
        const name = root.notif?.appName || "";
        return name.length > 0 ? name.charAt(0).toUpperCase() : "?";
      }
      color: Colors.fg
      font.pixelSize: root.size * 0.29
      font.weight: 600
      font.family: "SF Pro Display"
    }
  }
}
