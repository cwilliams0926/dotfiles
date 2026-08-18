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

  color: "#000000"
  clip: true
  radius: Math.min(height / 2, 26)

  implicitWidth: content.item ? content.item.implicitWidth : 150
  implicitHeight: content.item ? content.item.implicitHeight : 34

  Connections {
    target: AudioManager
    function onVolumeChanged() {
      // Don't hijack the launcher/theme picker/etc. mid-use just because
      // volume happened to change — only auto-show over the idle clock,
      // or extend an already-showing OSD.
      if (island.mode === "clock" || island.mode === "volumeosd") {
        island.mode = "volumeosd";
        osdHideTimer.restart();
      }
    }
  }

  Timer {
    id: osdHideTimer
    interval: 1500
    onTriggered: island.mode = "clock"
  }

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

  IpcHandler {
    target: "powerMenu"

    function toggle(): void {
      island.mode = island.mode === "powerMenu" ? "clock" : "powerMenu";
    }
  }
}
