import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs
import qs.singletons

Item {
  id: root
  signal closeRequested

  implicitWidth: 440
  implicitHeight: 96

  readonly property var actions: [
    {
      label: "Lock",
      icon: "lock",
      command: ["hyprlock"]
    },
    {
      label: "Log Out",
      icon: "logout",
      command: ["hyprctl", "dispatch", "exit"]
    },
    {
      label: "Suspend",
      icon: "do_not_disturb_on",
      command: ["systemctl", "suspend"]
    },
    {
      label: "Reboot",
      icon: "refresh",
      command: ["systemctl", "reboot"]
    },
    {
      label: "Power Off",
      icon: "power_settings_new",
      command: ["systemctl", "poweroff"]
    }
  ]

  Row {
    anchors.centerIn: parent
    spacing: 8

    Repeater {
      model: root.actions

      delegate: Rectangle {
        id: buttonRoot
        width: (root.width / 5) - 12
        height: 70
        radius: 12
        color: mouseArea.containsMouse ? Colors.aqua : Colors.bg0

        Column {
          spacing: 6
          anchors.centerIn: parent
          Text {
            id: buttonIcon
            text: modelData.icon
            font.pixelSize: 14
            font.family: "Material Symbols Rounded"
            color: mouseArea.containsMouse ? Colors.bg0 : Colors.fg
          }
          Text {
            text: modelData.label
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            color: mouseArea.containsMouse ? Colors.bg0 : Colors.fg
            font {
              pixelSize: 12
              weight: 600
              family: "SF Pro Display"
            }
          }
        }

        MouseArea {
          id: mouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            PowerManager.runAction(modelData.command);
            root.closeRequested();
          }
        }
      }
    }
  }
}
