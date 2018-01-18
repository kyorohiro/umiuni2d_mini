part of io_webgl;

class WebglFileSystem extends io.FileSystem {

  FileSystem _fileSystem;

  Future<FileSystem> init() async {
    _fileSystem = await window.requestFileSystem(1024, persistent: true);
    return _fileSystem;
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
    path = await toAbsoltePath(path);
    FileSystem fs = await init();
    html.Entry e = await fs.root.createDirectory(path,exclusive: false);
    return this;
  }

  Future<io.FileSystem> rm(String path,{bool recursive: false}) async {
    path = await toAbsoltePath(path);
    FileSystem fs = await init();
    try {
      html.Entry f  = await fs.root.getFile(path);
      f.remove();
    } catch(e) {
      Entry e = await fs.root.getDirectory(path);
      if(!e.isDirectory){
        throw "not found " + path;
      } else {
        html.DirectoryEntry d = await fs.root.getDirectory(path);
        if(recursive) {
          d.removeRecursively();
        } else {
          d.remove();
        }
      }
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
    FileSystem fs = await init();
    try {
      html.Entry f  = await fs.root.getFile(path);
      yield f.fullPath;
    } catch(e) {
      Entry e = await fs.root.getDirectory(path);
      if(!e.isDirectory){
        throw "not found " + path;
      } else {
        DirectoryEntry d = await fs.root.getDirectory(path);
        List<Entry> ds = await d.createReader().readEntries();
        for(Entry e in ds) {
          yield e.fullPath + (e.isDirectory?"/":"");
        }
      }
    }
  }

  Future<io.File> open(String path) async {
    path = await toAbsoltePath(path);
    FileSystem fs = await init();
    List<String> pat = path.split("/");
    String dir = "/";
    String fname = pat[pat.length-1];
    for(int i=0;i<pat.length -1;i++) {
      dir += pat[i]+"/";
    }
    html.DirectoryEntry ff = await fs.root.getDirectory(dir);
    return new TinyWebglFile(await ff.createFile(fname, exclusive: false) as html.FileEntry) ;
  }

  Future<String> getHomeDirectory() async {
    FileSystem  fs = await init();
    return fs.root.fullPath;
  }
}