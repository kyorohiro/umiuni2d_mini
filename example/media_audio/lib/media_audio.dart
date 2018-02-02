import 'dart:math' as math;
import 'package:umiuni2d/core.dart';
import 'package:umiuni2d/io.dart';
import 'package:umiuni2d/media.dart';

import 'dart:async';
import 'dart:convert' as conv;

class PrimitiveTest extends DisplayObject {
  Image image = null;
  PrimitiveTest();

  void onInit(Stage stage) {
    new Future(() async {
      print("## A1");
      MediaManager mediaManager = await stage.builder.getMediaManager();
      print("## A2");
      AudioSource src = await mediaManager.loadAudio("assets/bgm_maoudamashii_acoustic09.mp3");
      print("## A3");
      try {
        await src.start();
      } catch(e) {
        print("#ERR "+ e.toString());
      }
      print("## A4");
      await new Future.delayed(new Duration(seconds: 10));
      print("## A5");
      src.pause();
      print("## A6");
      stage.stop();
    });
  }

  void onPaint(Stage stage, Canvas canvas) {
  }
}
