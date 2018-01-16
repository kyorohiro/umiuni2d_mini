part of io_flutter;

class IOBuilderForFlutter extends io.IOBuilder {
  String assetsRoot;
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
  Future<io.File> loadFile(String name) async  {
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
