part of io_webgl;

class WebglFileSystem extends io.FileSystem {

  FileSystem _fileSystem;

  Future<Entry> init() async {
    _fileSystem = await window.requestFileSystem(1024, persistent: true);
  }

  Future<io.FileSystem> checkPermission() async {
    Completer<io.FileSystem> ret = new Completer();
    window.navigator.persistentStorage.requestQuota(5 * 1024 * 1024, (a) {
      ret.complete(this);
    }, (b) {
      ret.completeError(b);
    });
    return ret.future;
  }

  Future<io.FileSystem> mkdir(String path) async {
    return this;
  }

  Future<io.FileSystem> rm(String path,{bool recursive: false}) async {
    return this;
  }

  Stream<String> ls(String path) async* {
    FileSystem fs = await window.requestFileSystem(1024, persistent: true);
  }

  Future<io.File> open(String path) async {
    return null;
  }

  Future<String> getHomeDirectory() async {
    FileSystem fs = await window.requestFileSystem(1024, persistent: true);
    return fs.root.fullPath;
  }
}