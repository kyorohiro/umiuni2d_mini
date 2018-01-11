import 'package:umiuni2d/core.dart';
import 'package:umiuni2d_webgl/core.dart';
import 'package:example/primitive_test.dart';

void main() {
  TinyGameBuilderForWebgl builder = new TinyGameBuilderForWebgl();
  TinyGameRoot root = new TinyGameRoot(400.0,300.0);
  TinyStage stage = builder.createStage(root: root);
  (stage as TinyWebglStage).isTMode = true;
  stage.start();
  PrimitiveTest test = new PrimitiveTest(builder);
  root.addChild(test);
}
