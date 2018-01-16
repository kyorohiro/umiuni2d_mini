//
//
// Flutter entry point
//
//

import 'package:flutter/widgets.dart';
import 'package:umiuni2d_flutter/core.dart';
import 'chara_test.dart';

void main() {
  GameWidget game = new GameWidget();
  game.stage.root.addChild(new CharaGameRoot());
  runApp(game);
  game.start();
}
