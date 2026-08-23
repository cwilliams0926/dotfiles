import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import qs

Item {
  id: root

  property int barCount: 4
  property real barWidth: 3
  property real barSpacing: 2
  property real maxBarHeight: 12
  property real minBarHeight: 3
  property color barColor: Colors.fg

  readonly property var activePlayer: {
    const players = Mpris.players.values;
    for (let i = 0; i < players.length; i++) {
      if (players[i].isPlaying)
        return players[i];
    }
    return null;
  }
  readonly property bool isPlaying: activePlayer !== null

  implicitWidth: barCount * barWidth + (barCount - 1) * barSpacing
  implicitHeight: maxBarHeight
  width: implicitWidth   // <- plain Item needs this explicitly
  height: implicitHeight // <- same
  visible: root.isPlaying

  Row {
    anchors.bottom: parent.bottom
    spacing: root.barSpacing

    Repeater {
      model: root.barCount
      Rectangle {
        width: root.barWidth
        height: root.minBarHeight
        radius: width / 2
        color: root.barColor
        anchors.bottom: parent.bottom

        SequentialAnimation {
          running: root.isPlaying
          loops: Animation.Infinite
          NumberAnimation {
            target: parent
            property: "height"
            to: root.maxBarHeight
            duration: 280 + index * 60
            easing.type: Easing.InOutSine
          }
          NumberAnimation {
            target: parent
            property: "height"
            to: root.minBarHeight
            duration: 280 + index * 60
            easing.type: Easing.InOutSine
          }
        }
      }
    }
  }
}
