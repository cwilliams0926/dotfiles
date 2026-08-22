import QtQuick
import Quickshell
import qs
import qs.singletons

Item {
  id: root

  readonly property var notif: NotificationManager.activeNotification
  readonly property bool hasNotif: notif !== null

  implicitWidth: 364
  implicitHeight: 72
  clip: true

  Row {
    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      leftMargin: 12
      right: parent.right
      rightMargin: 12
    }
    spacing: 8

    Rectangle {
      id: iconFrame
      width: 48
      height: 48
      radius: width / 2
      color: Colors.aqua
      clip: true

      Image {
        id: iconImage
        anchors.fill: parent
        visible: root.hasNotif && status === Image.Ready
        source: root.notif?.appIcon || ""
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
      }

      // Letter fallback — shows when there's no icon,
      // OR when the icon source failed to load
      Text {
        anchors.centerIn: parent
        visible: !iconImage.visible
        text: {
          const name = root.notif?.appName || "";
          return name.length > 0 ? name.charAt(0).toUpperCase() : "?";
        }
        color: Colors.bg0
        font.pixelSize: 14
        font.weight: 600
        font.family: "SF Pro Display"
      }
    }

    Column {
      width: root.implicitWidth - iconFrame.width - 8
      spacing: 2
      anchors.verticalCenter: iconFrame.verticalCenter

      Text {
        width: parent.width
        text: root.notif?.appName || ""
        color: Colors.fg
        font.pixelSize: 13
        font.weight: 600
        font.family: "SF Pro Display"
        elide: Text.ElideRight
      }

      Text {
        width: parent.width
        text: root.notif?.summary || ""
        color: Colors.grey2
        font.pixelSize: 12
        font.family: "SF Pro Display"
        elide: Text.ElideRight
      }
    }
  }
}
