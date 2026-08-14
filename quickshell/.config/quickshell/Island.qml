import QtQuick
import Quickshell

// The pill itself. This file should stay "dumb" — it doesn't know what a
// clock or a launcher IS, it just:
//   1. tracks which mode we're in
//   2. loads that mode's content component
//   3. sizes itself to whatever that content reports as its implicit size
//
// This is what makes the "morph into anything" trick work: every new
// feature (launcher, wallpaper picker, lock screen) is just a new file in
// modes/ that reports its own implicitWidth/implicitHeight. This file never
// needs to change again.
Rectangle {
  id: island

  // The single knob that controls what's showing. Later, an IpcHandler
  // (triggered by a WM keybind) or a click will just set this property.
  property string mode: "clock"

  // Only meaningful to modes that opt into it (see Loader.onLoaded below).
  // Hover-to-expand makes sense for a clock; it won't make sense for a
  // launcher, which will manage its own open/closed state instead.
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

    // "clock" -> modes/ClockMode.qml
    // Add modes/LauncherMode.qml, set island.mode = "launcher", done.
    source: "modes/" + island.mode.charAt(0).toUpperCase() + island.mode.slice(1) + "Mode.qml"

    onLoaded: {
      // Not every mode has a "collapsed" concept, so only wire up hover
      // if the loaded component actually declared that property.
      if (item && "collapsed" in item) {
        item.collapsed = Qt.binding(() => !island.hoverExpand);
      }
    }
  }
}
