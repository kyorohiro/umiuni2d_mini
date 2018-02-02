//
//
// WebGL entry point
//
//

import 'package:umiuni2d_webgl/core.dart';
import 'package:example/media_audio.dart';

void main() {
  GameWidget game = new GameWidget();
  game.stage.root.addChild(new PrimitiveTest());
  game.start();
}

