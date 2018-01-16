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
  GameWidget game = new GameWidget();
  game.stage.root.addChild(new PrimitiveTest(game.builder));
  runApp(game);
  game.start();
}
