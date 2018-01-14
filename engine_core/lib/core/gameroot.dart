part of core;

class GameRoot extends DisplayObject {
  double w = 800.0;
  double h = 600.0;
  double ratioW = 1.0;
  double ratioH = 1.0;
  double radio = 1.0;
  double l = 0.0;
  double t = 0.0;
  Color bkcolor;
  bool isClipRect;

  GameRoot(this.w, this.h, {this.bkcolor, this.isClipRect:true}) {
    if (bkcolor == null) {
      bkcolor = new Color.argb(0xff, 0xee, 0xee, 0xff);
    }
  }

  void updatePosition(TinyStage stage, int timeStamp) {
    ratioW = (stage.w - (stage.paddingLeft+stage.paddingRight)) / w;
    ratioH = (stage.h - (stage.paddingTop+stage.paddingBottom)) / h;
    radio = (ratioW < ratioH ? ratioW : ratioH);
    t = stage.paddingTop;
    l = (stage.w - (w * radio)) / 2 + stage.paddingLeft;
    mat = new Matrix4.identity();
    mat.translate(l, t, 0.0);
    mat.scale(radio, radio, 1.0);
  }

  bool touch(TinyStage stage, DisplayObject parent, int id, StagePointerType type, double x, double y) {
    //  stage.pushMulMatrix(mat);
      return super.touch(stage, parent, id, type, x, y);
      //stage.popMatrix();
    }

  void onTick(TinyStage stage, int timeStamp) {
    updatePosition(stage, timeStamp);
  }

  void paint(TinyStage stage, Canvas canvas) {
    Rect rect = new Rect(0.0, 0.0, w, h);
//    canvas.pushMulMatrix(mat);
    if(isClipRect == true) {
      canvas.pushClipRect(stage, rect);
    }
    super.paint(stage, canvas);
    if(isClipRect == true) {
      canvas.popClipRect(stage);
    }
//    canvas.popMatrix();
  }

  void onPaint(TinyStage stage, Canvas canvas) {
    Rect rect = new Rect(0.0, 0.0, w, h);
    Paint paint = new Paint();
    paint.color = bkcolor;
    canvas.drawRect(stage, rect, paint);
  }
}
