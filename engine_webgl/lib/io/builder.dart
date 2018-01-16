part of io_webgl;

class IOBuilderForWebgl extends io.IOBuilder {
  //
  // File
  //

  @override
  Future<io.File> loadFile(String name) async {
    return new TinyWebglFile(name);
  }

  @override
  Future<List<String>> getFiles() async {
    FileSystem e = await window.requestFileSystem(1024, persistent: true);
    List<Entry> files = await e.root.createReader().readEntries();
    List<String> ret = [];
    for (Entry e in files) {
      if (e.isFile) {
        ret.add(e.name);
      }
    }
    return ret;
  }
}
