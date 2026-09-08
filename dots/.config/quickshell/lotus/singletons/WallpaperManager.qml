pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Item {
  readonly property string wallpaperScript: Quickshell.env("HOME") + "/.config/scripts/apply-wallpaper"

  Process {
    id: wallpaperProcess
    stdinEnabled: false
  }

  function applyWallpaper(path) {
    if (wallpaperProcess.running) {
      console.warn("Wallpaper switch already running");
      return;
    }
    wallpaperProcess.command = [wallpaperScript, path];
    wallpaperProcess.running = true;
  }
}
