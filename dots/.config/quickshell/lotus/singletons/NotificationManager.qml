pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root

  property var activeNotification: null
  property var queue: []
  property var history: []

  function addToHistory(notification) {
    history = [...history, notification];
  }

  function removeFromHistory(notification) {
    history = history.filter(n => n !== notification);
  }

  function clearHistory() {
    history = [];
  }

  NotificationServer {
    id: server
    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: notification => {
      notification.tracked = true;
      root.addToHistory(notification);
      notification.closed.connect(function () {
        if (notification === root.activeNotification) {
          root.removeFromHistory(notification);
          root.showNext();
        } else {
          root.queue = root.queue.filter(n => n !== notification);
          root.removeFromHistory(notification);
        }
      });
      if (root.activeNotification === null) {
        root.activeNotification = notification;
        dismissTimer.restart();
      } else {
        root.queue = [...root.queue, notification];
      }
    }
  }
  Timer {
    id: dismissTimer
    interval: 5000
    onTriggered: root.dismissCurrent()
  }

  function showNext() {
    if (root.queue.length === 0) {
      activeNotification = null;
      return;
    } else {
      activeNotification = root.queue[0];
      root.queue = root.queue.slice(1);
    }
    dismissTimer.restart();
  }

  function dismissCurrent() {
    showNext();
  }
}
