import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import qs
import qs.singletons

Item {
  id: root
  signal closeRequested

  implicitWidth: 848
  implicitHeight: 264

  readonly property string wallpaperDir: Quickshell.env("HOME") + "/.config/wallpapers/" + ThemeManager.currentTheme

  property var wallpapers: []

  function refreshWallpapers() {
    listProc.command = ["find", root.wallpaperDir, "-maxdepth", "1", "-type", "f", "(", "-iname", "*.jpg", "-o", "-iname", "*.jpeg", "-o", "-iname", "*.png", "-o", "-iname", "*.webp", "-o", "-iname", "*.gif", ")"];
    listProc.running = true;
  }

  Process {
    id: listProc
    stdout: StdioCollector {
      onStreamFinished: {
        root.wallpapers = text.trim().split("\n").filter(line => line.length > 0);
      }
    }
  }

  Component.onCompleted: refreshWallpapers()

  // Re-list whenever the active theme changes — different theme means a
  // different wallpaper folder entirely.
  Connections {
    target: ThemeManager
    function onCurrentThemeChanged() {
      root.refreshWallpapers();
    }
  }

  Text {
    id: wallpaperText
    anchors {
      top: parent.top
      topMargin: 16
      left: parent.left
      leftMargin: 22
      right: parent.right
    }
    text: "Wallpaper"
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
      top: wallpaperText.bottom
      topMargin: 8
      right: parent.right
      rightMargin: 16
      left: parent.left
      leftMargin: 16
      bottom: parent.bottom
    }
    cellWidth: width / 6
    cellHeight: 100
    clip: true
    model: root.wallpapers
    delegate: Component {
      Item {
        id: cellRoot
        width: GridView.view.cellWidth
        height: GridView.view.cellHeight

        ClippingRectangle {
          id: thumbnailCard
          anchors.fill: parent
          anchors.margins: 4
          radius: 12
          clip: true

          border.width: 2
          border.color: mouseArea.containsMouse ? Colors.aqua : "transparent"

          Image {
            anchors.fill: parent
            source: modelData.startsWith("file://") ? modelData : "file://" + modelData
            sourceSize.width: 200
            sourceSize.height: 150
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
          }

          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
              WallpaperManager.applyWallpaper(modelData);
              root.closeRequested();
            }
          }
        }
      }
    }
  }
}
