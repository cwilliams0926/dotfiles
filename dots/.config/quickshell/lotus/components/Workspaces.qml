import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland
import qs

Row {
  id: root

  // Tweak these to taste
  property int count: 5
  property real dotWidth: 8
  property real idleHeight: 10
  property real activeHeight: 18
  property real dotRadius: 3
  property color idleColor: Colors.bg0
  property color activeColor: Colors.aqua

  readonly property int currentId: Hyprland.focusedWorkspace?.id ?? 1

  spacing: 5

  Repeater {
    model: root.count

    // Fixed-height wrapper: Row positions this, the pill centers itself inside
    delegate: Item {
      id: slot
      required property int index
      readonly property bool active: root.currentId === index + 1

      width: root.dotWidth
      height: root.activeHeight

      Rectangle {
        id: pill
        anchors.centerIn: parent
        width: root.dotWidth
        height: slot.active ? root.activeHeight : root.idleHeight
        radius: root.dotRadius
        color: slot.active ? root.activeColor : root.idleColor
        visible: false   // MultiEffect draws it (plus the glow)

        Behavior on height {
          NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
          }
        }
        Behavior on color {
          ColorAnimation {
            duration: 180
          }
        }
      }

      MultiEffect {
        anchors.fill: pill
        source: pill
        autoPaddingEnabled: true
        shadowEnabled: true
        shadowColor: root.activeColor
        shadowBlur: 0.8
        shadowOpacity: slot.active ? 0.7 : 0.0
        Behavior on shadowOpacity {
          NumberAnimation {
            duration: 180
          }
        }
      }
    }
  }
}
