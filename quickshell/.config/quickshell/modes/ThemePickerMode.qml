import QtQuick
import QtQuick.Layouts
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
      swatch: ["#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482"],
      background: "#141617",
      foreground: "#d4be98"
    },
    {
      name: "catppuccin",
      swatch: ["#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#cba6f7", "#89dceb"],
      background: "#11111b",
      foreground: "#cdd6f4"
    },
    {
      name: "everforest",
      swatch: ["#e67e80", "#a7c080", "#dbbc7f", "#7fbbb3", "#d699b6", "#83c092"],
      background: "#272e33",
      foreground: "#d3c6aa"
    },
    {
      name: "gruvbox",
      swatch: ["#fb4934", "#b8bb26", "#fabd2f", "#83a598", "#d3869b", "#8ec07c"],
      background: "#141617",
      foreground: "#ebdbb2"
    },
    {
      name: "rose-pine",
      swatch: ["#eb6f92", "#9ccfd8", "#f6c177", "#31748f", "#c4a7e7", "#9ccfd8"],
      background: "#191724",
      foreground: "#e0def4"
    },
    {
      name: "e-ink",
      swatch: ["#9a9a9a", "#7c7c7c", "#868686", "#686868", "#5e5e5e", "#727272"],
      background: "#cccccc",
      foreground: "#333333"
    },
    {
      name: "tokyonight",
      swatch: ["#ff757f", "#c3e88d", "#ffc777", "#82aaff", "#c099ff", "#86e1fc"],
      background: "#1e2030",
      foreground: "#c8d3f5"
    },
    {
      name: "kanagawa",
      swatch: ["#e82424", "#98bb6c", "#e6c384", "#7e9cd8", "#957fb8", "#6a9589"],
      background: "#16161d",
      foreground: "#dcd7ba"
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
          border.color: mouseArea.containsMouse ? Colors.aqua : "transparent"

          color: modelData.background

          ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8

            Item {
              Layout.fillHeight: true
            }

            RowLayout {
              Layout.alignment: Qt.AlignHCenter
              Rectangle {
                width: 12
                height: 12
                radius: height / 2
                color: modelData.swatch[0]
              }
              Rectangle {
                width: 12
                height: 12
                radius: height / 2
                color: modelData.swatch[1]
              }
              Rectangle {
                width: 12
                height: 12
                radius: height / 2
                color: modelData.swatch[2]
              }
              Rectangle {
                width: 12
                height: 12
                radius: height / 2
                color: modelData.swatch[3]
              }
              Rectangle {
                width: 12
                height: 12
                radius: height / 2
                color: modelData.swatch[4]
              }
              Rectangle {
                width: 12
                height: 12
                radius: height / 2
                color: modelData.swatch[5]
              }
            }

            Item {
              Layout.fillHeight: true
            }

            Text {
              id: nameText
              Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
              text: modelData.name
              color: modelData.foreground
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
