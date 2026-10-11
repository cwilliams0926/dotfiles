import QtQuick
import QtQuick.Layouts
import qs
import qs.singletons

RowLayout {
  id: root
  spacing: 6
  readonly property int count: NotificationManager.history.length

  Text {
    Layout.alignment: Qt.AlignVCenter

    text: count === 0 ? "All caught up" : count + (count === 1 ? " notification" : " notifications")

    color: Colors.fg
    font {
      pixelSize: 13
      weight: 600
      family: "SF Pro Display"
    }
  }

  Text {
    Layout.alignment: Qt.AlignVCenter
    text: count === 0 ? "notifications" : "notifications_unread"
    color: Colors.fg
    font {
      pixelSize: 16
      family: "Material Symbols Rounded"
    }
  }
}
