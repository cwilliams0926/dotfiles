import QtQuick
import Quickshell
import qs
import qs.singletons
import qs.components

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

    NotificationIcon {
      id: iconFrame
      notif: root.notif
      size: 48
      anchors.verticalCenter: parent.verticalCenter
    }

    Column {
      width: root.implicitWidth - iconFrame.width - 8
      spacing: 2
      anchors.verticalCenter: iconFrame.verticalCenter

      Text {
        width: parent.width
        text: root.notif?.summary || ""
        color: Colors.fg
        font.pixelSize: 13
        font.weight: 600
        font.family: "SF Pro Display"
        elide: Text.ElideRight
      }

      Text {
        width: parent.width
        text: root.notif?.body || ""
        color: Colors.grey2
        font.pixelSize: 12
        font.family: "SF Pro Display"
        elide: Text.ElideRight
      }
    }
  }
}
