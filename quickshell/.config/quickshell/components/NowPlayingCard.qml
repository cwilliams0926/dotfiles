import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import ".."

// Fixed size always — this no longer collapses to 0 width when nothing's
// playing. Instead it swaps its *internal content* between real track
// info and a placeholder, based on hasMedia. The component always exists
// in the same place; only what's drawn inside it changes.
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
      // Placeholder glyph shown when nothing's playing — a plain music
      // note character, no extra asset needed. Swap for an icon/SVG
      // later if you want something fancier.
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

      Text {
        width: parent.width
        text: root.hasMedia ? (root.activePlayer.trackTitle || "Unknown Title") : "Nothing playing"
        color: Colors.fg
        font.pixelSize: 13
        font.weight: 600
        font.family: "SF Pro Display"
        elide: Text.ElideRight
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
