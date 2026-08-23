import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
  id: root

  property int size: 24

  component Corner: PanelWindow {
    required property bool isTop
    required property bool isLeft

    implicitWidth: root.size
    implicitHeight: root.size

    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    anchors {
      top: isTop
      bottom: !isTop
      left: isLeft
      right: !isLeft
    }

    Canvas {
      anchors.fill: parent

      onPaint: {
        const ctx = getContext("2d");
        const size = root.size;

        ctx.reset();

        // Match the Cairo code:
        // Fill the square, then cut out the circle.
        ctx.beginPath();
        ctx.rect(0, 0, width, height);

        const cx = isLeft ? size : 0;
        const cy = isTop ? size : 0;

        ctx.moveTo(cx + size, cy);
        ctx.arc(cx, cy, size, 0, Math.PI * 2);

        ctx.fillStyle = "black";
        ctx.fill("evenodd");
      }
    }
  }

  Corner {
    isTop: true
    isLeft: true
  }

  Corner {
    isTop: true
    isLeft: false
  }

  Corner {
    isTop: false
    isLeft: true
  }

  Corner {
    isTop: false
    isLeft: false
  }
}
