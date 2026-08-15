import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "../components"
import ".."

Item {
  id: root
  signal closeRequested

  property string query: ""
  property bool collapsed: true

  implicitWidth: 440
  implicitHeight: 346

  Component.onCompleted: textInput.forceActiveFocus()

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

  RowLayout {
    id: searchBar
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

    Item {
      id: searchInputWrapper
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignVCenter
      implicitHeight: textInput.implicitHeight

      TextInput {
        id: textInput
        anchors.fill: parent
        color: Colors.fg
        onTextChanged: root.query = text

        Keys.onPressed: event => {
          if (event.key === Qt.Key_Down) {
            listView.currentIndex = Math.min(listView.currentIndex + 1, filteredApps.values.length - 1);
            event.accepted = true;
          } else if (event.key === Qt.Key_Up) {
            listView.currentIndex = Math.max(listView.currentIndex - 1, 0);
            event.accepted = true;
          } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            const selected = filteredApps.values[listView.currentIndex];
            if (selected) {
              selected.execute();
              root.closeRequested();
            }
            event.accepted = true;
          } else if (event.key === Qt.Key_Escape) {
            root.closeRequested();
            event.accepted = true;
          }
        }
      }

      Text {
        anchors.verticalCenter: textInput.verticalCenter
        text: "Search..."
        color: Colors.grey2
        visible: textInput.text.length === 0
        font.family: "SF Pro Display"
      }
    }
  }

  Rectangle {
    id: separator
    anchors {
      top: searchBar.bottom
      topMargin: 8
      right: parent.right
      rightMargin: 16
      left: parent.left
      leftMargin: 16
    }
    height: 1
    width: parent.width
    color: Colors.bg2
    radius: height / 2
  }

  ListView {
    id: listView
    anchors {
      top: searchBar.bottom
      topMargin: 16
      left: parent.left
      leftMargin: 16
      right: parent.right
      rightMargin: 16
      bottom: parent.bottom
    }
    clip: true
    spacing: 2
    model: filteredApps
    delegate: Component {
      Rectangle {
        id: delegateRoot
        width: ListView.view.width
        height: 44
        color: (mouseArea.containsMouse || delegateRoot.ListView.isCurrentItem) ? Colors.bg2 : "transparent"
        radius: 8

        Row {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 10
          spacing: 8

          Rectangle {
            id: iconFrame
            width: 32
            height: 32
            y: (parent.height - height) / 2
            radius: 8
            color: "transparent"
            clip: true

            Image {
              anchors.fill: parent

              source: Quickshell.iconPath(modelData.icon)
              fillMode: Image.PreserveAspectCrop
              asynchronous: true
            }
          }

          Column {
            spacing: 2
            y: (parent.height - height) / 2
            width: delegateRoot.width - iconFrame.width - 16

            Text {
              text: modelData.name
              width: parent.width
              elide: Text.ElideRight
              color: Colors.fg
              font.pixelSize: 14
              font.weight: 700
              font.family: "SF Pro Display"
            }
            Text {
              text: modelData.comment || ""
              width: parent.width
              elide: Text.ElideRight
              color: Colors.grey2
              font.pixelSize: 13
              font.family: "SF Pro Display"
            }
          }
        }

        MouseArea {
          id: mouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            modelData.execute();
            root.closeRequested();
          }
        }
      }
    }
  }
  onQueryChanged: listView.currentIndex = 0
}
