import { Astal, Gtk } from "ags/gtk4"
import Cairo from "gi://cairo"

const SIZE = 15

const corners = {
  "top-left": {
    anchor: Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT,
    cx: SIZE,
    cy: SIZE,
  },
  "top-right": {
    anchor: Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT,
    cx: 0,
    cy: SIZE,
  },
  "bottom-left": {
    anchor: Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT,
    cx: SIZE,
    cy: 0,
  },
  "bottom-right": {
    anchor: Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT,
    cx: 0,
    cy: 0,
  },
}

export default function ScreenCorners() {
  return Object.entries(corners).map(([name, { anchor, cx, cy }]) => {
    const da = new Gtk.DrawingArea()

    da.set_content_width(SIZE)
    da.set_content_height(SIZE)

    da.set_draw_func((_self, cr, w, h) => {
      cr.rectangle(0, 0, w, h)
      cr.newSubPath()
      cr.arc(cx, cy, SIZE, 0, 2 * Math.PI)
      cr.setFillRule(Cairo.FillRule.EVEN_ODD)
      cr.setSourceRGBA(0, 0, 0, 1)
      cr.fill()
    })

    return (
      <window
        visible
        cssClasses={["corner"]}
        namespace={`corner-${name}`}
        anchor={anchor}
        exclusivity={Astal.Exclusivity.IGNORE}
        layer={Astal.Layer.OVERLAY}
      >
        {da}
      </window>
    )
  })
}
