library core;
import 'dart:async';
import 'package:vector_math/vector_math_64.dart';
import 'util.dart';
import 'dart:typed_data';
import 'dart:math' as math;
//
part 'core/canvas.dart';
part 'core/canvas_roze.dart';
part 'core/color.dart';
part 'core/displayobject.dart';
part 'core/gameroot.dart';
part 'core/image.dart';
part 'core/paint.dart';
part 'core/point.dart';
part 'core/rect.dart';
part 'core/size.dart';
part 'core/sprite.dart';
part 'core/stage.dart';
part 'core/stage_base.dart';
part 'core/builder.dart';


abstract class Platform {
  Future<double> getDisplayDensity();
  Future<String> loadString(String path);
  Future<Image> loadImage(String path);
  Future<Uint8List> loadBytes(String path);
  Future<String> getLocale();
}