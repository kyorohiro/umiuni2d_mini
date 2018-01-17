part of io_flutter;

class IOBuilderForFlutter extends io.IOBuilder {
  String assetsRoot;
  //
  // File
  //
  dio.Directory rootPath;

  Future initFile() async {
    if (rootPath == null) {
      path.Umiuni2dPlatformPath p = new path.Umiuni2dPlatformPath();
      String rootPathSrc = await p.getApplicationDirectory();
      rootPath = new dio.Directory(rootPathSrc);
    }
  }

  @override
  Future<io.File> loadFile(String name) async  {
    await initFile();
    dio.File f = new dio.File("${rootPath.path}/${name}");
    return new TinyFlutterFile(f);
  }

  @override
  Future<List<String>> getFiles() async {
    await initFile();
    List<String> ret = [];
    await for (dio.FileSystemEntity fse in rootPath.list()) {
      ret.add(fse.path.split("/").last);
    }
    return ret;
  }

}
