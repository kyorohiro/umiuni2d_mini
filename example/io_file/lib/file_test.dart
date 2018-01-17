import 'dart:math' as math;
import 'package:umiuni2d/core.dart';
import 'package:umiuni2d/io.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:async';

class PrimitiveTest extends DisplayObject {
  Image image = null;
  PrimitiveTest();

  void onInit(Stage stage) {
    new Future(() async {
      FileSystem fs = await stage.builder.getFileSystem();
      String homeDir = await fs.getHomeDirectory();
      print("#HOME DIR ${homeDir}");
      for(String f in await fs.ls(homeDir+"../").toList()) {
        print("#LS ${f}");
      }
    });
  }

  void onPaint(Stage stage, Canvas canvas) {
  }
}
