//
//
// Flutter entry point
//
//

import 'package:umiuni2d_flutter/core.dart';
import 'primitive_test.dart';

void main() {
  GameWidget game = new GameWidget();
  game.stage.root.addChild(new PrimitiveTest());
  game.start();
}
