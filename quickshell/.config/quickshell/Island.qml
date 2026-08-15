import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

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
    // Only react to hover actually CHANGING, not "what's true right now."
    // A freshly-loaded mode's initial state comes from onLoaded below
    // (always a sane default), never from a live snapshot of hoverExpand
    // — that snapshot can be stale/misleading right at the moment a new
    // mode loads, e.g. if the pill just shrank out from under a cursor
    // that was previously inside its larger (launcher) bounds.
    onHoveredChanged: {
      if (content.item && "collapsed" in content.item) {
        content.item.collapsed = !hovered;
      }
    }
  }

  Loader {
    id: content
    anchors.centerIn: parent
    source: "modes/" + island.mode.charAt(0).toUpperCase() + island.mode.slice(1) + "Mode.qml"

    onLoaded: {
      // Every freshly-loaded mode starts collapsed by default, regardless
      // of whatever hoverExpand happens to be at this exact instant.
      // Live hover tracking from here on is entirely the HoverHandler's
      // job, above — not this initial value.
      if (item && "collapsed" in item) {
        item.collapsed = true;
      }
      if (item && item.closeRequested) {
        item.closeRequested.connect(() => {
          island.mode = "clock";
        });
      }
    }
  }

  IpcHandler {
    target: "launcher"

    function toggle(): void {
      island.mode = island.mode === "launcher" ? "clock" : "launcher";
    }
  }

  IpcHandler {
    target: "themePicker"

    function toggle(): void {
      island.mode = island.mode === "themePicker" ? "clock" : "themePicker";
    }
  }

  IpcHandler {
    target: "wallpaperPicker"

    function toggle(): void {
      island.mode = island.mode === "wallpaperPicker" ? "clock" : "wallpaperPicker";
    }
  }
}
