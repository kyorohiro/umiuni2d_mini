library tinygame_webgl;

import 'dart:html' as html;
import 'dart:async';
import 'package:umiuni2d/core.dart' as core;

import 'package:vector_math/vector_math_64.dart';
import 'dart:html';
import 'dart:web_gl';
import 'dart:typed_data';
import 'dart:convert' as conv;
//
import 'package:umiuni2d/io.dart' as io;
import 'io.dart' as io;
import 'package:umiuni2d/media.dart' as media;
import 'media.dart' as media;
//
part 'core/stage.dart';
part 'core/util.dart';
part 'core/loader.dart';
part 'core/image.dart';
part 'core/canvas.dart';
part 'core/context.dart';
part 'core/builder.dart';

part 'util/canvas_text.dart';

class GameWidget {
  core.Stage _stage;
  core.Stage get stage => _stage;
  TinyGameBuilderForWebgl _builder = null;
  TinyGameBuilderForWebgl get builder => _builder;

  GameWidget({
    TinyGameBuilderForWebgl builder:null,
    core.DisplayObject root:null,
    double width:400.0,
    double height:300.0,
    String assetsRoot:"",
    String selectors: null}) {
    if(builder == null) {
      builder = new TinyGameBuilderForWebgl(assetsRoot: assetsRoot);
    }
    if(root == null) {
      root = new core.GameRoot(width, height);
    }
    this._builder = builder;
    builder.selectors = selectors;
    this._stage = builder.createStage(root: root);
    (this._stage as TinyWebglStage).isTMode = true;
  }

  void start() {
    stage.start();
  }

  void stop() {
    stage.stop();
  }
}
