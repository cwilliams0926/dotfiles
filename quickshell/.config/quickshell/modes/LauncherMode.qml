import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "../components"
import ".."

// TODO: think about implicitWidth/implicitHeight here the same way
// ClockMode does — the launcher probably wants a fixed, larger size
// (it needs room for a search bar + several list rows), not something
// that shrinks/grows the way the clock's collapsed/expanded does.
Item {
  id: root

  property string query: ""
  property bool collapsed: true

  implicitWidth: 440
  implicitHeight: 346

  ScriptModel {
    id: filteredApps
    values: {
      const all = [...DesktopEntries.applications.values].filter(app => app.name).sort((a, b) => a.name.localeCompare(b.name));
      const q = root.query.trim().toLowerCase();
      if (q === "")
        return all;
      return all.filter(app => app.name.toLowerCase().includes(q));
    }
  }

  // TODO: build the search bar — a Row containing:
  //   - a Text with "🔍" (or similar), sized/colored to match your theme
  //   - a TextInput bound to root.query, so typing updates the filter
  //     above automatically via the binding it already reads from
  // Anchor this Row near the top of root.

  RowLayout {
    anchors {
      top: parent.top
      right: parent.right
      left: parent.left
      margins: 16
    }
    spacing: 16

    Text {
      id: magnify
      Layout.alignment: Qt.AlignVCenter
      text: ""
      font {
        pixelSize: 14
      }
      color: Colors.fg
    }

    TextInput {
      id: textInput
      Layout.alignment: Qt.AlignVCenter
      Layout.fillWidth: true
      color: Colors.fg
      text: "Search..."
      focus: true

      onAccepted: {
        console.log("User typed" + textInput.text);
      }
    }
  }
  // TODO: build the ListView below the search bar:
  //   ListView {
  //     model: filteredApps
  //     delegate: Component {
  //       // `modelData` here is one DesktopEntry from the array above.
  //       // Build a Row: an Image/IconImage using
  //       //   Quickshell.iconPath(modelData.icon)
  //       // next to a Text showing modelData.name — same shape as
  //       // NowPlayingCard's art-next-to-text layout.
  //     }
  //   }
  //
  // Give the ListView real anchors/height so it actually has room to
  // render rows — an Item with no size shows nothing, same lesson as
  // your very first RowLayout bug.

  // TODO: launching — when a row is clicked (or Enter is pressed on the
  // selected one), call modelData.execute(), then close the launcher by
  // setting island.mode back to "clock". You'll need a way to reach
  // `island` from here — think about whether that should be a signal
  // this file emits upward, or something else. This is a real design
  // choice, not a fact I'm withholding.
}
