import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs

RowLayout {
  id: root

  property int iconSize: 16
  property int maxTextWidth: 120

  readonly property var toplevel: ToplevelManager.activeToplevel
  readonly property string appId: toplevel?.appId ?? ""
  readonly property var entry: appId !== "" ? DesktopEntries.heuristicLookup(appId) : null
  readonly property string appName: entry?.name ?? (appId || "Desktop")
  spacing: 6

  Image {
    Layout.alignment: Qt.AlignVCenter
    Layout.preferredWidth: root.iconSize
    Layout.preferredHeight: root.iconSize

    sourceSize: Qt.size(32, 32)
    source: Quickshell.iconPath(root.entry?.icon ?? root.appId, "application-x-executable")
    fillMode: Image.PreserveAspectFit
    smooth: true
    mipmap: true
    asynchronous: true
  }

  Text {
    Layout.alignment: Qt.AlignVCenter
    Layout.maximumWidth: root.maxTextWidth
    text: root.appName
    color: Colors.fg
    elide: Text.ElideRight
    font {
      pixelSize: 13
      weight: 600
      family: "SF Pro Display"
    }
  }
}
