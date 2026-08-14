import QtQuick
import Quickshell

Rectangle {
  id: island

  property string mode: "clock"

  property bool hoverExpand: hover.hovered

  anchors.horizontalCenter: parent.horizontalCenter
  anchors.top: parent.top
  anchors.topMargin: 8

  color: Colors.bg0
  clip: true
  radius: Math.min(height / 2, 26)

  implicitWidth: content.item ? content.item.implicitWidth : 150
  implicitHeight: content.item ? content.item.implicitHeight : 34

  Behavior on implicitWidth {
    SpringAnimation {
      spring: 3.0
      damping: 0.3
      mass: 0.7
    }
  }
  Behavior on implicitHeight {
    SpringAnimation {
      spring: 3.0
      damping: 0.3
      mass: 0.7
    }
  }

  HoverHandler {
    id: hover
  }

  Loader {
    id: content
    anchors.centerIn: parent

    source: "modes/" + island.mode.charAt(0).toUpperCase() + island.mode.slice(1) + "Mode.qml"

    onLoaded: {
      if (item && "collapsed" in item) {
        item.collapsed = Qt.binding(() => !island.hoverExpand);
      }
    }
  }
}
