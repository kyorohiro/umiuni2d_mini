import 'dart:math' as math;
import 'package:umiuni2d/core.dart';
import 'package:umiuni2d/io.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:async';
import 'dart:convert' as conv;

class PrimitiveTest extends DisplayObject {
  Image image = null;
  PrimitiveTest();

  void onInit(Stage stage) {
    new Future(() async {
      FileSystem fs = await stage.builder.getFileSystem();
      await fs.checkPermission();

      String homeDir = await fs.getHomeDirectory();
      print("#HOME DIR ${homeDir}");
      for(String f in await fs.ls(homeDir).toList()) {
        print("#LS ${(homeDir)}: ${f}");
      }
      await fs.mkdir("test");
      File f = await fs.open("test/test.txt");
      await f.writeAsBytes(conv.UTF8.encode("Hello!!"), 0);
      for(String f in await fs.ls(homeDir+"test/").toList()) {
        print("#LS ${(homeDir+"test/")}: ${f}");
      }
      //
      fs.rm("test",recursive: true);
    });
  }

  void onPaint(Stage stage, Canvas canvas) {
  }
}
