library core;
import 'dart:async';
import 'package:vector_math/vector_math_64.dart';
import 'util.dart';

part 'core/canvas.dart';
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
part 'core/displayobject_expansion.dart';
part 'core/displayobject_expansion_item.dart';


abstract class TinyGameBuilder {
  TinyStage createStage({TinyDisplayObject root});
}
