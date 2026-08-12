pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  FileView {
    id: colorsFile

    path: Quickshell.env("HOME") + "/.config/quickshell/colors.json"
    watchChanges: true
    onFileChanged: reload()

    JsonAdapter {
      id: adapter

      property string bg0: "#11111b"
      property string bg1: "#181825"
      property string bg2: "#1e1e2e"
      property string bg3: "#313244"
      property string bg4: "#45475a"

      property string fg: "#cdd6f4"

      property string red: "#f38ba8"
      property string orange: "#fab387"
      property string yellow: "#f9e2af"
      property string green: "#a6e3a1"
      property string aqua: "#89dceb"
      property string blue: "#89b4fa"
      property string purple: "#dba6f7"
      property string pink: "#f5c2e7"

      property string grey0: "#6c7086"
      property string grey1: "#7f849c"
      property string grey2: "#9399b2"
    }
  }

  property alias bg0: adapter.bg0
  property alias bg1: adapter.bg1
  property alias bg2: adapter.bg2
  property alias bg3: adapter.bg3
  property alias bg4: adapter.bg4

  property alias fg: adapter.fg

  property alias red: adapter.red
  property alias orange: adapter.orange
  property alias yellow: adapter.yellow
  property alias green: adapter.green
  property alias aqua: adapter.aqua
  property alias blue: adapter.blue
  property alias purple: adapter.purple
  property alias pink: adapter.pink

  property alias grey0: adapter.grey0
  property alias grey1: adapter.grey1
  property alias grey2: adapter.grey2
}
