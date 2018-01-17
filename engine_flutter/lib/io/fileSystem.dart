part of io_flutter;

class FlutterFileSystem extends io.FileSystem {
  path.Umiuni2dPlatformPath _path = new path.Umiuni2dPlatformPath();

  FlutterFileSystem();

  Future<bool> checkPermission() async {
    return true;
  }

  Future<io.FileSystem> mkdir(String path) async {
    return this;
  }

  Future<io.FileSystem> rmDir(String path) async {
    return this;
  }

  Future<List<String>> ls(String path) async {
    return <String>[];
  }

  Future<io.File> open(String path) async {
    return null;
  }

  Future<String> getHomeDirectory() async {
    return _path.getApplicationDirectory();
  }

}