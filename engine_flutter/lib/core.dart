library tinygame_flutter;

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as sky;
import 'dart:async';
import 'dart:math'as math;
import 'dart:io';
import 'dart:typed_data' as data;
import 'package:vector_math/vector_math_64.dart';
import 'package:umiuni2d/core.dart' as core;
import 'package:umiuni2d/io.dart' as io;
import 'io.dart' as io;

//
//
part 'core/stage.dart';
part 'core/ncanvas.dart';
part 'core/builder.dart';
part 'core/loader.dart';
//
//

class GameWidget extends SingleChildRenderObjectWidget {
  core.Stage _stage;
  core.Stage get stage => _stage;
  TinyGameBuilderForFlutter _builder = null;
  TinyGameBuilderForFlutter get builder => _builder;

  GameWidget({
    TinyGameBuilderForFlutter builder:null,
    core.DisplayObject root:null,
    double width:400.0,
    double height:300.0,
    String assetsRoot:"web/"}) {
    if(builder == null) {
      builder = new TinyGameBuilderForFlutter(assetsRoot: assetsRoot);
    }
    if(root == null) {
      root = new core.GameRoot(width, height);
    }
    this._builder = builder;
    this._stage = builder.createStage(root: root);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    builder.useTestCanvas = true;
    return (stage as TinyFlutterStage);
  }

  void start() {
    stage.start();
  }

  void stop() {
    stage.stop();
  }
}