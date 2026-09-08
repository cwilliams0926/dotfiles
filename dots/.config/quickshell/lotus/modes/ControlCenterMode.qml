import QtQuick
import Quickshell.Widgets
import qs.singletons
import qs.components
import qs

Item {
  id: root
  property bool collapsed: true
  readonly property real bodyHeight: NotificationManager.history.length > 0 ? listView.height : placeholderText.implicitHeight + placeholderText.topPadding

  implicitWidth: 440
  implicitHeight: Math.min(400, headerRow.implicitHeight + bodyHeight + 24)

  Column {
    anchors.fill: parent
    anchors.margins: 16
    spacing: 8

    Item {
      id: headerRow
      width: parent.width
      implicitHeight: Math.max(titleText.implicitHeight, clearButton.implicitHeight)
      Text {
        id: titleText
        text: "Notifications"
        color: Colors.fg
        font.pixelSize: 14
        font.weight: 600
        font.family: "SF Pro Display"
      }
      Text {
        id: clearButton
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: "Clear all"
        color: Colors.aqua
        font.pixelSize: 12
        font.family: "SF Pro Display"

        TapHandler {
          onTapped: NotificationManager.clearHistory()
        }

        HoverHandler {
          cursorShape: Qt.PointingHandCursor
        }
      }
    }

    ListView {
      id: listView
      width: parent.width
      height: Math.min(NotificationManager.history.length, 5) * itemHeight
      visible: NotificationManager.history.length > 0
      model: NotificationManager.history
      spacing: 6
      interactive: true
      clip: true

      property real itemHeight: 40

      delegate: ClippingRectangle {
        width: listView.width
        height: listView.itemHeight
        color: Colors.bg0
        radius: 12

        Row {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 12
          spacing: 8

          NotificationIcon {
            notif: modelData
            size: 32
            anchors.verticalCenter: parent.verticalCenter
          }

          Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 1
            Text {
              text: modelData.summary || ""
              color: Colors.fg
              font.pixelSize: 12
              font.weight: 600
              font.family: "SF Pro Display"
            }
            Text {
              text: modelData.body || ""
              color: Colors.grey2
              font.pixelSize: 11
              font.family: "SF Pro Display"
            }
          }
        }
      }
    }
    Text {
      id: placeholderText
      anchors.horizontalCenter: parent.horizontalCenter
      visible: NotificationManager.history.length === 0
      text: "No notifications"
      color: Colors.grey2
      font.pixelSize: 13
      font.family: "SF Pro Display"
      topPadding: 12
    }
  }
}
