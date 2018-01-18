part of io;


abstract class File {
  Future<int> writeAsBytes(List<int> buffer, int offset);
  Future<List<int>> readAsBytes(int offset, int length);
  Future<int> getLength();
  Future<int> truncate(int fileSize);
  Future<File> close();
}

abstract class FileSystem {
  Future<FileSystem> checkPermission();
  Future<FileSystem> mkdir(String path);
  Future<FileSystem> rm(String path,{bool recursive: false});
  Stream<String> ls(String path);
  Future<File> open(String path);
  Future<String> getHomeDirectory();
}
