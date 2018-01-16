part of tinygame_flutter;

class TinyGameBuilderForFlutter extends core.GameBuilder {
  String assetsRoot;

  TinyGameBuilderForFlutter({this.assetsRoot: "web/"}) {
    ;
  }

  String get assetsPath => (assetsRoot.endsWith("/") ? assetsRoot : "${assetsRoot}/");

  bool tickInPerFrame = true;
  bool useTestCanvas = true; //false;
  bool useDrawVertexForPrimtive = true;

  @override
  core.Stage createStage({core.DisplayObject root}) {
    if(root == null) {
      root = new core.DisplayObject();
    }
    return new TinyFlutterStage(this, root, tickInPerFrame: tickInPerFrame, useTestCanvas: useTestCanvas, useDrawVertexForPrimtive: useDrawVertexForPrimtive);
  }

  @override
  Future<core.Image> loadImage(String path) async {
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

  //
  // File
  //
  Directory rootPath;

  Future initFile() async {
    if (rootPath == null) {
      ppath.Umiuni2dPlatformPath p = new ppath.Umiuni2dPlatformPath();
      String rootPathSrc = await p.getApplicationDirectory();
      rootPath = new Directory(rootPathSrc);
    }
  }

  @override
  Future<core.File> loadFile(String name) async  {
    await initFile();
    File f = new File("${rootPath.path}/${name}");
    return new TinyFlutterFile(f);
  }

  @override
  Future<List<String>> getFiles() async {
    await initFile();
    List<String> ret = [];
    await for (FileSystemEntity fse in rootPath.list()) {
      ret.add(fse.path.split("/").last);
    }
    return ret;
  }

}
