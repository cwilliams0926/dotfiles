import QtQuick
import Quickshell
import Quickshell.Widgets
import qs
import qs.singletons

Item {
  id: root
  signal closeRequested

  implicitWidth: 440
  implicitHeight: 320

  readonly property var themes: [
    {
      name: "gruvbox-material",
      swatch: ["#ea6962", "#d8a657", "#a9b665"]
    },
    {
      name: "catppuccin",
      swatch: ["#89b4fa", "#cba6f7", "#f38ba8"]
    },
    {
      name: "everforest",
      swatch: ["#a7c080", "#dbbc7f", "#e67e80"]
    },
    {
      name: "gruvbox",
      swatch: ["#fb4934", "#fabd2f", "#b8bb26"]
    },
    {
      name: "rose-pine",
      swatch: ["#eb6f92", "#9ccfd8", "#31748f"]
    },
    {
      name: "e-ink",
      swatch: ["#1a1a1a", "#555555", "#aaaaaa"]
    },
    {
      name: "tokyonight",
      swatch: ["#7aa2f7", "#bb9af7", "#f7768e"]
    },
    {
      name: "kanagawa",
      swatch: ["#7e9cd8", "#957fb8", "#c34043"]
    }
  ]

  function applyTheme(name) {
    ThemeManager.applyTheme(name);
    root.closeRequested();
  }

  Text {
    id: themeText
    anchors {
      top: parent.top
      topMargin: 16
      left: parent.left
      leftMargin: 22
      right: parent.right
    }
    text: "Theme"
    color: Colors.fg
    font {
      pixelSize: 14
      weight: 700
      family: "SF Pro Display"
    }
  }

  GridView {
    id: gridView
    anchors {
      top: themeText.bottom
      topMargin: 8
      right: parent.right
      rightMargin: 16
      left: parent.left
      leftMargin: 16
      bottom: parent.bottom
    }
    cellWidth: width / 3
    cellHeight: 100
    clip: true
    model: root.themes
    delegate: Component {
      Item {
        id: cellRoot
        width: GridView.view.cellWidth
        height: GridView.view.cellHeight

        ClippingRectangle {
          id: swatchCard
          anchors.fill: parent
          anchors.margins: 4
          radius: 12
          clip: true

          border.width: 2
          border.color: (cellRoot.GridView.isCurrentItem || mouseArea.containsMouse) ? Colors.fg : "transparent"

          Row {
            anchors.fill: parent
            spacing: 0

            Rectangle {
              width: parent.width / 3
              height: parent.height
              color: modelData.swatch[0]
            }
            Rectangle {
              width: parent.width / 3
              height: parent.height
              color: modelData.swatch[1]
            }
            Rectangle {
              width: parent.width / 3
              height: parent.height
              color: modelData.swatch[2]
            }
          }

          Rectangle {
            anchors.centerIn: parent
            width: nameText.implicitWidth + 16
            height: nameText.implicitHeight + 8
            radius: 6
            color: Qt.rgba(0, 0, 0, 0.45)

            Text {
              id: nameText
              anchors.centerIn: parent
              text: modelData.name
              color: Colors.fg
              font {
                pixelSize: 14
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
              root.applyTheme(modelData.name);
            }
          }
        }
      }
    }
  }
}
