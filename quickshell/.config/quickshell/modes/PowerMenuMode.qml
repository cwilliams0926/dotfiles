import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import ".."

Item {
  id: root
  signal closeRequested

  implicitWidth: 440
  implicitHeight: 96

  readonly property var actions: [
    {
      label: "Lock",
      icon: "system-lock-screen-symbolic",
      command: ["hyprlock"]
    },
    {
      label: "Log Out",
      icon: "system-log-out-symbolic",
      command: ["hyprctl", "dispatch", "exit"]
    },
    {
      label: "Suspend",
      icon: "system-suspend-symbolic",
      command: ["systemctl", "suspend"]
    },
    {
      label: "Reboot",
      icon: "system-reboot-symbolic",
      command: ["systemctl", "reboot"]
    },
    {
      label: "Power Off",
      icon: "system-shutdown-symbolic",
      command: ["systemctl", "poweroff"]
    }
  ]

  Process {
    id: actionProcess
  }

  function runAction(command) {
    actionProcess.command = command;
    actionProcess.running = true;
    root.closeRequested();
  }

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
        color: mouseArea.containsMouse ? Colors.blue : Colors.bg0

        Column {
          spacing: 6
          anchors.centerIn: parent
          Item {
            width: 24
            height: 24

            IconImage {
              id: buttonIcon
              anchors.fill: parent
              source: Quickshell.iconPath(modelData.icon)
              asynchronous: true
            }

            MultiEffect {
              anchors.fill: buttonIcon
              source: buttonIcon

              colorization: 1.0
              colorizationColor: mouseArea.containsMouse ? Colors.bg0 : Colors.fg
            }
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
            root.runAction(modelData.command);
          }
        }
      }
    }
  }
}
