import QtQuick
import Quickshell
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

    Rectangle {
      id: artFrame
      width: 48
      height: 48
      radius: 8
      color: Colors.bg1
      clip: true

      Image {
        anchors.fill: parent
        visible: root.hasMedia

        source: {
          const art = root.activePlayer?.trackArtUrl || "";

          if (!art)
            return "";

          if (art.startsWith("/"))
            return "file://" + art;

          return art;
        }

        fillMode: Image.PreserveAspectCrop
        asynchronous: true
      }

      // Placeholder glyph for when nothing's playing
      Text {
        anchors.centerIn: parent
        visible: !root.hasMedia
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
