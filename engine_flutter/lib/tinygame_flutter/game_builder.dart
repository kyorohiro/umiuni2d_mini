part of tinygame_flutter;

class TinyGameBuilderForFlutter extends core.TinyGameBuilder {
  String assetsRoot;

  TinyGameBuilderForFlutter({this.assetsRoot: "web/"}) {
    ;
  }

  String get assetsPath => (assetsRoot.endsWith("/") ? assetsRoot : "${assetsRoot}/");

  bool tickInPerFrame = true;
  bool useTestCanvas = true; //false;
  bool useDrawVertexForPrimtive = true;

  @override
  core.TinyStage createStage({core.TinyDisplayObject root}) {
    if(root == null) {
      root = new core.TinyDisplayObject();
    }
    return new TinyFlutterStage(this, root, tickInPerFrame: tickInPerFrame, useTestCanvas: useTestCanvas, useDrawVertexForPrimtive: useDrawVertexForPrimtive);
  }

  @override
  Future<core.TinyImage> loadImage(String path) async {
    return new TinyFlutterImage(await ResourceLoader.loadImage("${assetsPath}${path}"));
  }

  @override
  Future<data.Uint8List> loadBytes(String path) async {
    return await ResourceLoader.loadBytes("${assetsRoot}${path}");
  }

  @override
  Future<String> loadString(String path) async {
    String a = await ResourceLoader.loadString("${assetsRoot}${path}");
    return a;
  }

  @override
  Future<String> getLocale() async {
    return sky.window.locale.languageCode;
  }

  @override
  Future<double> getDisplayDensity() async {
    return sky.window.devicePixelRatio;
  }

}
