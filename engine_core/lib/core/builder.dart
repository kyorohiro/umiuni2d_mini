part of core;

abstract class GameBuilder {
  Stage createStage({DisplayObject root});
  Future<double> getDisplayDensity();
  Future<String> loadString(String path);
  Future<Image> loadImage(String path);
  Future<Uint8List> loadBytes(String path);
  //
  Future<String> getLocale();
}

abstract class GameBuilderWithCaches {
  Map<String, Image> cach = {};
  Map<String, String> cachString = {};
  Map<String, Uint8List> cachBytes = {};
  GameBuilder _base;
  GameBuilderWithCaches(GameBuilder base) {
    this._base = base;
  }
  Map<String, Image> cach = {};
  Map<String, String> cachString = {};
  Map<String, Uint8List> cachBytes = {};
  //
  Future<Image> loadImage(String path) async {
    if (cach.containsKey(path)) {
      return cach[path];
    }
    cach[path] = await _base.loadImage(path);
    return cach[path];
  }

  Future<String> loadString(String path) async {
    if (cachString.containsKey(path)) {
      return cachString[path];
    }
    cachString[path] = await _base.loadString(path);
    return cachString[path];
  }

  Future<Uint8List> loadBytes(String path) async {
    if (cachBytes.containsKey(path)) {
      return cachBytes[path];
    }
    cachBytes[path] = await _base.loadBytes(path);
    return cachBytes[path];
  }

  Uint8List getBytes(String path) {
    if (cachBytes.containsKey(path)) {
      return cachBytes[path];
    }
    return null;
  }

  String getString(String path) {
    if (cachString.containsKey(path)) {
      return cachString[path];
    }
    return null;
  }

  Image getImage(String path) {
    if (cach.containsKey(path)) {
      return cach[path];
    }
    return null;
  }

  Future clearImageCash({bool callDispose: true, List<String> excepts: null}) async {
    Map<String, Image> nextImageCach = {};
    excepts = (excepts == null ? [] : excepts);
    if (callDispose == true) {
      for (String k in cach.keys) {
        if (false == excepts.contains(k)) {
          Image i = cach[k];
          i.dispose();
        } else {
          nextImageCach[k] = cach[k];
        }
      }
    }
    cach.clear();
    cach = nextImageCach;
  }

  Future clearStringCash() async {
    cachString.clear();
  }

  Future clearBytesCash() async {
    cachBytes.clear();
  }

}