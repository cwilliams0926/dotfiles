import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs

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

  implicitWidth: 170
  implicitHeight: 48
  clip: true

  Row {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 8

    ClippingRectangle {
      id: artFrame
      width: 48
      height: 48
      radius: 12
      color: Colors.bg1
      clip: true

      // Tracks the last successfully-seen art URL, separate from
      // the live (sometimes-empty) trackArtUrl binding
      property string lastGoodArt: ""

      Connections {
        target: root.activePlayer
        function onTrackArtUrlChanged() {
          const art = root.activePlayer?.trackArtUrl || "";
          if (art.length > 0) {
            artFrame.lastGoodArt = art.startsWith("/") ? "file://" + art : art;
          }
        }
      }

      Image {
        anchors.fill: parent
        visible: root.hasMedia && artFrame.lastGoodArt.length > 0 && status === Image.Ready
        source: artFrame.lastGoodArt
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
      }

      Text {
        anchors.centerIn: parent
        visible: !root.hasMedia || artFrame.lastGoodArt.length === 0
        text: "\u266A"
        color: Colors.grey2
        font.pixelSize: 20
      }
    }

    Column {
      width: 114
      spacing: 2
      anchors.verticalCenter: artFrame.verticalCenter

      Row {
        spacing: 4
        EqualizerIcon {
          anchors.verticalCenter: titleText.verticalCenter
        }
        Text {
          id: titleText
          text: root.hasMedia ? (root.activePlayer.trackTitle || "Unknown Title") : "Nothing playing"
          color: Colors.fg
          font.pixelSize: 13
          font.weight: 600
          font.family: "SF Pro Display"
          elide: Text.ElideRight
        }
      }

      Text {
        width: parent.width
        text: root.hasMedia ? (root.activePlayer.trackArtist || "Unknown Artist") : "—"
        color: Colors.grey2
        font.pixelSize: 12
        font.family: "SF Pro Display"
        elide: Text.ElideRight
      }
    }
  }
}
