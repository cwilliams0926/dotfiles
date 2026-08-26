import QtQuick
import qs.singletons
import qs.components
import qs

Item {
  id: root
  property bool collapsed: true

  implicitWidth: 320
  implicitHeight: Math.min(400, headerRow.implicitHeight + listView.contentHeight + 24)

  Column {
    anchors.fill: parent
    anchors.margins: 12
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
      }
    }

    ListView {
      id: listView
      width: parent.width
      height: contentHeight
      model: NotificationManager.history
      spacing: 6
      interactive: false // TODO: reconsider once list can exceed visible height

      delegate: Item {
        width: listView.width
        height: 40

        Row {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
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
  }
}
