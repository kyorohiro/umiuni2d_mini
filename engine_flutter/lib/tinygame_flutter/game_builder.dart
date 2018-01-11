part of tinygame_flutter;

class TinyGameBuilderForFlutter extends TinyGameBuilder {
  String assetsRoot;

  TinyGameBuilderForFlutter({this.assetsRoot: "web/"}) {
    ;
  }

  String get assetsPath => (assetsRoot.endsWith("/") ? assetsRoot : "${assetsRoot}/");

  bool tickInPerFrame = true;
  bool useTestCanvas = true; //false;
  bool useDrawVertexForPrimtive = true;

  @override
  TinyStage createStage({TinyDisplayObject root}) {
    if(root == null) {
      root = new TinyDisplayObject();
    }
    return new TinyFlutterStage(this, root, tickInPerFrame: tickInPerFrame, useTestCanvas: useTestCanvas, useDrawVertexForPrimtive: useDrawVertexForPrimtive);
  }

  @override
  Future<TinyImage> loadImageBase(String path) async {
    return new TinyFlutterImage(await ResourceLoader.loadImage("${assetsPath}${path}"));
  }

  @override
  Future<data.Uint8List> loadBytesBase(String path) async {
    return await ResourceLoader.loadBytes("${assetsRoot}${path}");
  }

  @override
  Future<String> loadStringBase(String path) async {
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
