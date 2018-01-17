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

  Stream<String> ls(String path) async* {
    if(path == "" || path == "/" || path == "./") {
      path = await getHomeDirectory();
    } else if(!path.startsWith("/") && !path.contains("://")) {
      path = await getHomeDirectory() + path;
    }
    dio.Directory d = new dio.Directory(path);
    if(false == await d.exists()){
      // not found
      throw "not found "+ path;
    }
    await for(dio.FileSystemEntity f in d.list()) {
        bool isDir = await dio.FileSystemEntity.isDirectory(f.path);
        yield f.path + (isDir?"/":"");
    }
  }

  Future<io.File> open(String path) async {
    return null;
  }

  Future<String> getHomeDirectory() async {
    return await _path.getApplicationDirectory() + "/";
  }

}