part of core;

enum TinyPaintStyle { fill, stroke }

class Paint {
  Color color;
  TinyPaintStyle style = TinyPaintStyle.fill;
  double strokeWidth = 1.0;
  Paint({this.color}) {
    if (this.color == null) {
      color = new Color.argb(0xff, 0xff, 0xff, 0xff);
    }
  }
}
