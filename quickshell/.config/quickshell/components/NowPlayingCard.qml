import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import ".."

// The Mpris logic that used to live directly in ClockMode now lives here
// instead — same code, just relocated so it's self-contained like the
// other components. ClockMode no longer needs to import
// Quickshell.Services.Mpris at all.
Item {
  id: root

  readonly property var activePlayer: {
    const players = Mpris.players.values;
    for (let i = 0; i < players.length; i++) {
      if (players[i].isPlaying)
        return players[i];
    }
    return players.length > 0 ? players[0] : null;
  }
  readonly property bool hasMedia: activePlayer !== null

  // implicitWidth collapses to 0 when nothing's playing, so a parent Row
  // laying this out alongside other elements shrinks automatically —
  // no manual "hide and also remove its spacing" bookkeeping needed.
  implicitWidth: hasMedia ? 170 : 0
  implicitHeight: 48
  visible: hasMedia
  clip: true

  Row {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 8

    Rectangle {
      id: artFrame
      width: 48
      height: 48
      radius: 8
      color: Colors.bg1
      clip: true
      // Note: plain Item.clip rounds corners less precisely than
      // Quickshell.Widgets.ClippingRectangle does for busy images — fine
      // here, but worth knowing if you want pixel-perfect corners later.

      Image {
        anchors.fill: parent
        source: root.activePlayer ? (root.activePlayer.trackArtUrl || "") : ""
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
      }
    }

    Column {
      width: 114
      spacing: 2
      anchors.verticalCenter: artFrame.verticalCenter

      Text {
        width: parent.width
        text: root.activePlayer ? (root.activePlayer.trackTitle || "Unknown Title") : ""
        color: Colors.fg
        font.pixelSize: 13
        font.weight: 600
        font.family: "SF Pro Display"
        elide: Text.ElideRight
      }

      Text {
        width: parent.width
        text: root.activePlayer ? (root.activePlayer.trackArtist || "Unknown Artist") : ""
        color: Colors.grey2
        font.pixelSize: 12
        font.family: "SF Pro Display"
        elide: Text.ElideRight
      }
    }
  }
}
