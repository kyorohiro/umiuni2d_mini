part of core;

abstract class GameWidget {
  Stage _stage;
  Stage get stage => _stage;
  void start();
  void stop();
  void run();

  Stage createStage({DisplayObject root});
  Future<double> getDisplayDensity();
  Future<String> loadString(String path);
  Future<Image> loadImage(String path);
  Future<Uint8List> loadBytes(String path);
  Future<String> getLocale();
  //
  //
  //Map<String, Image> _cachImage = {};
  //Map<String, Uint8List> cachBytes = {};


}

/*
abstract class GameBuilderWithCaches {
  Map<String, Image> _cachImage = {};
  Map<String, Uint8List> cachBytes = {};
  GameBuilder _base;
  GameBuilderWithCaches(GameBuilder base) {
    this._base = base;
  }
  //
  Future<Image> loadImage(String path) async {
    if (_cachImage.containsKey(path)) {
      return _cachImage[path];
    }
    _cachImage[path] = await _base.loadImage(path);
    return _cachImage[path];
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


  Image getImage(String path) {
    if (_cachImage.containsKey(path)) {
      return _cachImage[path];
    }
    return null;
  }

  Future clearImageCash({bool callDispose: true, List<String> excepts: null}) async {
    Map<String, Image> nextImageCach = {};
    excepts = (excepts == null ? [] : excepts);
    if (callDispose == true) {
      for (String k in _cachImage.keys) {
        if (false == excepts.contains(k)) {
          Image i = _cachImage[k];
          i.dispose();
        } else {
          nextImageCach[k] = _cachImage[k];
        }
      }
    }
    _cachImage.clear();
    _cachImage = nextImageCach;
  }

  Future clearBytesCash() async {
    cachBytes.clear();
  }

}
*/