part of io;

abstract class IOBuilder {
  Future<File> loadFile(String name);
  Future<List<String>> getFiles();
}

