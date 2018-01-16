//
//
// WebGL entry point
//
//

import 'package:umiuni2d/core.dart';
import 'package:umiuni2d_webgl/core.dart';
import 'package:example/primitive_test.dart';

void main() {
  TinyGameBuilderForWebgl builder = new TinyGameBuilderForWebgl();
  GameWidget game = new GameWidget();
  PrimitiveTest test = new PrimitiveTest();
  game.stage.root.addChild(test);
  game.start();
}

