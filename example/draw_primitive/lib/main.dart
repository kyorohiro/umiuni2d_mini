//
//
// Flutter entry point
//
//
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:umiuni2d/core.dart';
import 'package:umiuni2d_flutter/core.dart';
import 'primitive_test.dart';

void main() {
  runApp(new GameWidget());
}

class GameWidget extends SingleChildRenderObjectWidget {
  GameWidget() {}

  @override
  RenderObject createRenderObject(BuildContext context) {
    TinyGameBuilderForFlutter builder = new TinyGameBuilderForFlutter(assetsRoot:"web/");
    builder.useTestCanvas = true;
    GameRoot root = new GameRoot(400.0, 300.0);
    TinyStage stage = builder.createStage(root: root);
    stage.start();
    stage.root.addChild(new PrimitiveTest(builder));
    return (stage as TinyFlutterStage);
  }
}