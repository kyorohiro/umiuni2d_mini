part of io_flutter;

class FlutterFileSystem extends io.FileSystem {
  path.Umiuni2dPlatformPath _path = new path.Umiuni2dPlatformPath();

  FlutterFileSystem();

  Future<bool> checkPermission() async {
    //
    // this method is for html5 filesystem api.
    // flutter return true.
    return true;
  }

  Future<io.FileSystem> mkdir(String path) async {
    path = await toAbsoltePath(path);
    dio.Directory d = new dio.Directory(path);
    if(await d.exists()) {
      d.create(recursive: true);
    }
    return this;
  }

  Future<io.FileSystem> rmDir(String path,{bool recursive: false}) async {
    path = await toAbsoltePath(path);
    dio.Directory d = new dio.Directory(path);
    if(await d.exists()) {
      d.delete(recursive: recursive);
    }
    return this;
  }

  Future<String> toAbsoltePath(String path) async {
    if(path == "" || path == "/" || path == "./") {
      path = await getHomeDirectory();
    } else if(!path.startsWith("/") && !path.contains("://")) {
      path = await getHomeDirectory() + path;
    }
    return path;
  }

  Stream<String> ls(String path) async* {
    path = await toAbsoltePath(path);
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
    path = await toAbsoltePath(path);
    dio.File f = new dio.File(path);
    return new TinyFlutterFile(f);
  }

  Future<String> getHomeDirectory() async {
    return await _path.getApplicationDirectory() + "/";
  }

}