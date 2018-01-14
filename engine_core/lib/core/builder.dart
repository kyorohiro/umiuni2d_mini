part of core;

abstract class TinyGameBuilder {
  Map<String, TinyImage> cach = {};
  Map<String, String> cachString = {};
  Map<String, Uint8List> cachBytes = {};

  TinyStage createStage({TinyDisplayObject root});

  Future<String> getLocale();

  Future<double> getDisplayDensity();

  Future<String> loadString(String path);

  Future<TinyImage> loadImage(String path);

  Future<Uint8List> loadBytes(String path);
}

abstract class TinyGameBuilderWithCaches {
  TinyGameBuilder _base;
  TinyGameBuilderWithCaches(TinyGameBuilder base) {
    this._base = base;
  }
  Map<String, TinyImage> cach = {};
  Map<String, String> cachString = {};
  Map<String, Uint8List> cachBytes = {};
  //
  Future<TinyImage> loadImage(String path) async {
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

  TinyImage getImage(String path) {
    if (cach.containsKey(path)) {
      return cach[path];
    }
    return null;
  }

  Future clearImageCash({bool callDispose: true, List<String> excepts: null}) async {
    Map<String, TinyImage> nextImageCach = {};
    excepts = (excepts == null ? [] : excepts);
    if (callDispose == true) {
      for (String k in cach.keys) {
        if (false == excepts.contains(k)) {
          TinyImage i = cach[k];
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