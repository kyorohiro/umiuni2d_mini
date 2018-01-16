part of tinygame_webgl;

class TinyGameBuilderForWebgl extends core.GameBuilder {
  String assetsRoot = "";
  String get assetsPath => (assetsRoot.endsWith("/")?assetsRoot:"${assetsRoot}/");
  int width = 600;
  int height = 400;
  int paintInterval = 40;
  int tickInterval = 15;
  String selectors = null;
  double fontPower = 2.0;
  TinyGameBuilderForWebgl({this.assetsRoot:""}) {}

  core.Stage createStage({core.DisplayObject root}) {
    if(root == null) {
      root = new core.DisplayObject();
    }
    return new TinyWebglStage(this, root, width:width.toDouble(), height:height.toDouble(), selectors:selectors, tickInterval:tickInterval, paintInterval:paintInterval);
  }

  Future<core.Image> loadImage(String path) async {
    ImageElement elm = await TinyWebglLoader.loadImage("${assetsPath}${path}");
    return new TinyWebglImage(elm);
  }

  Future<Uint8List> loadBytes(String path) async {
    Completer<Uint8List> c = new Completer();
    HttpRequest request = new HttpRequest();
    request.open("GET", "${assetsRoot}${path}");
    request.responseType = "arraybuffer";
    request.onLoad.listen((ProgressEvent e) async {
      ByteBuffer buffer = request.response;
      c.complete(buffer.asUint8List());
    });
    request.onError.listen((ProgressEvent e) {
      c.completeError(e);
    });
    request.send();
    return c.future;
  }

  Future<String> loadString(String path) async {
    Uint8List buffer = await loadBytes(path);
    return await conv.UTF8.decode(buffer, allowMalformed: true);
  }


  Future<String> getLocale() async {
    return window.navigator.language;
  }

  Future<double> getDisplayDensity() async {
    return window.devicePixelRatio;
  }

}
