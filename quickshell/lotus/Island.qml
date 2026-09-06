import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.singletons

Rectangle {
  id: island

  property string mode: "clock"
  property bool hoverExpand: hover.hovered
  property bool audioReady: false
  property bool brightnessReady: false
  property bool nightLightReady: false

  anchors.horizontalCenter: parent.horizontalCenter
  anchors.top: parent.top
  anchors.topMargin: 9

  color: ThemeManager.currentTheme === "e-ink" ? Colors.bg0 : "#000000"
  clip: true
  radius: Math.min(height / 2, 26)

  implicitWidth: content.item ? content.item.implicitWidth : 150
  implicitHeight: content.item ? content.item.implicitHeight : 34

  Connections {
    target: AudioManager

    function onVolumeChanged() {
      if (!island.audioReady)
        return;

      if (island.mode === "clock" || island.mode === "volumeOsd") {
        island.mode = "volumeOsd";
        osdHideTimer.restart();
      }
    }

    function onMutedChanged() {
      if (!island.audioReady)
        return;

      if (island.mode === "clock" || island.mode === "volumeOsd") {
        island.mode = "volumeOsd";
        osdHideTimer.restart();
      }
    }
  }

  Connections {
    target: BrightnessManager

    function onBrightnessChanged() {
      if (!island.brightnessReady)
        return;

      if (island.mode === "clock" || island.mode === "brightnessOsd") {
        island.mode = "brightnessOsd";
        osdHideTimer.restart();
      }
    }
  }

  Connections {
    target: NightLightManager

    function onOnChanged() {
      if (!island.nightLightReady)
        return;

      if (island.mode === "clock" || island.mode === "nightLightOsd") {
        island.mode = "nightLightOsd";
        osdHideTimer.restart();
      }
    }
  }

  Connections {
    target: NotificationManager
    function onActiveNotificationChanged() {
      if (NotificationManager.activeNotification !== null) {
        island.mode = "notification";
      } else {
        // TODO: only revert if island.mode === "notification"
        //       (avoid stomping a mode the user switched to manually
        //        while a notification happened to be showing)
        island.mode = "clock";
      }
    }
  }

  Timer {
    id: osdHideTimer
    interval: 2000
    onTriggered: island.mode = "clock"
  }

  // So that osds don't appear on shell open
  Timer {
    interval: 1000
    running: true
    repeat: false

    onTriggered: {
      island.audioReady = true;
    }
  }
  Timer {
    interval: 1000
    running: true
    repeat: false

    onTriggered: {
      island.brightnessReady = true;
    }
  }
  Timer {
    interval: 500
    running: true
    repeat: false

    onTriggered: {
      island.nightLightReady = true;
    }
  }

  Behavior on implicitWidth {
    SpringAnimation {
      spring: 5.0
      damping: 0.37
      mass: 0.7
      epsilon: 0.25
    }
  }
  Behavior on implicitHeight {
    SpringAnimation {
      spring: 5.0
      damping: 0.37
      mass: 0.7
      epsilon: 0.25
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

  IpcHandler {
    target: "brightness"

    function refresh(): void {
      BrightnessManager.refresh();
    }
  }

  IpcHandler {
    target: "controlCenter"

    function toggle(): void {
      island.mode = island.mode === "controlCenter" ? "clock" : "controlCenter";
    }
  }

  IpcHandler {
    target: "nightLight"

    function on(): void {
      NightLightManager.setOn(true);
    }

    function off(): void {
      NightLightManager.setOn(false);
    }
  }
}
