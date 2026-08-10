import app from "ags/gtk4/app"
import style from "./style.scss"
import ScreenCorners from "./widget/ScreenCorners"

app.start({
  css: style,
  main() {
    ScreenCorners();
  },
})
