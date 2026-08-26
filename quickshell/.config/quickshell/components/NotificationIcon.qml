import QtQuick
import qs

Item {
  id: root
  property var notif: null
  property real size: 48
  property color fallbackColor: Colors.aqua

  implicitWidth: size
  implicitHeight: size

  readonly property bool hasIcon: iconImage.status === Image.Ready

  Image {
    id: iconImage
    anchors.fill: parent
    visible: root.hasIcon
    source: root.notif?.appIcon || ""
    fillMode: Image.PreserveAspectCrop
    asynchronous: true
  }

  Rectangle {
    id: iconFrame
    anchors.fill: parent
    radius: width / 2
    color: Colors.bg3
    clip: true
    visible: !root.hasIcon

    Rectangle {
      width: parent.width - 14
      height: parent.height - 14
      anchors.centerIn: parent
      radius: width / 2
      color: root.fallbackColor
      clip: true

      Text {
        anchors.centerIn: parent
        text: {
          const name = root.notif?.appName || "";
          return name.length > 0 ? name.charAt(0).toUpperCase() : "?";
        }
        color: Colors.bg0
        font.pixelSize: root.size * 0.29
        font.weight: 600
        font.family: "SF Pro Display"
      }
    }
  }
}
