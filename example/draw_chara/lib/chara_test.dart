library gamelogic;

import 'dart:async';
import 'dart:math' as math;
import 'package:umiuni2d/core.dart' as umiuni2d;

class CharaGameRoot  extends umiuni2d.DisplayObject {
  umiuni2d.GameBuilder _builder;
  umiuni2d.Sprite chara;
  umiuni2d.Stage _stage = null;

  CharaGameRoot();

  void onInit(umiuni2d.Stage stage) {
    _stage = stage;
    _builder = stage.builder;
    gameLoop();
  }

  void onUnattach() {
    _stage = null;
  }

  Future<CharaGameRoot> gameLoop() async {
    umiuni2d.Sprite chara = await createChara(_builder);
    _stage.root.addChild(chara);
    chara.x = 200.0;
    chara.y = 150.0;
    chara.centerX = 100.0;
    chara.centerY = 100.0;
    chara.scaleX = 0.8;
    chara.scaleY = 0.8;

    int prevTime = 0;
    while (_stage != null) {
      int timeStamp = new DateTime.now().millisecondsSinceEpoch;
      chara.rotation -= math.PI * ((timeStamp - prevTime) / 1000);
      prevTime = timeStamp;
      chara.currentFrameID++;
      if (chara.currentFrameID >= chara.numOfFrameID) {
        chara.currentFrameID = 0;
      }
      _stage.markPaintshot();
      await new Future.delayed(new Duration(milliseconds: 50));
    }
    return this;
  }

  Future<umiuni2d.Sprite> createChara(umiuni2d.GameBuilder builder) async {
    umiuni2d.Image img = await builder.loadImage("assets/chara.png");
    return new umiuni2d.Sprite.simple(img, srcs: [
      new umiuni2d.Rect(0.0, 0.0, 200.0, 200.0),
      new umiuni2d.Rect(200.0, 0.0, 200.0, 200.0),
      new umiuni2d.Rect(0.0, 200.0, 200.0, 200.0)
    ], dsts: [
      new umiuni2d.Rect(0.0, 0.0, 200.0, 200.0),
      new umiuni2d.Rect(0.0, 0.0, 200.0, 200.0),
      new umiuni2d.Rect(0.0, 0.0, 200.0, 200.0)
    ], transforms: [
      umiuni2d.TinyCanvasTransform.NONE,
      umiuni2d.TinyCanvasTransform.NONE,
      umiuni2d.TinyCanvasTransform.NONE
    ]);
  }
}