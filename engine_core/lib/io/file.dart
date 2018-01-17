part of io;


abstract class File {
  Future<int> writeAsBytes(List<int> buffer, int offset);
  Future<List<int>> readAsBytes(int offset, int length);
  Future<int> getLength();
  Future<int> truncate(int fileSize);
}

abstract class FileSystem {
  Future<bool> checkPermission();
  Future<FileSystem> mkdir(String path);
  Future<FileSystem> rmDir(String path);
  Stream<String> ls(String path);
  Future<File> open(String path);
  Future<String> getHomeDirectory();
}
