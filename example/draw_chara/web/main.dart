//
//
// WebGL entry point
//
//

import 'package:umiuni2d_webgl/core.dart';
import 'package:example/chara_test.dart';

void main() {
  GameWidget game = new GameWidget();
  game.stage.root.addChild(new CharaGameRoot());
  game.start();
}

