part of io_flutter;

class TinyFlutterFile extends io.File {
  dio.RandomAccessFile af;
  TinyFlutterFile(this.af) {
  }

  Future<io.File> close() async {
    await af.close();
    return this;
  }

  @override
  Future<int> writeAsBytes(List<int> buffer, int offset) async {
    await af.setPosition(offset);
    await af.writeFrom(buffer);
    return buffer.length;
  }

  @override
  Future<List<int>> readAsBytes(int offset, int length) async {
    await af.setPosition(offset);
    List<int> ret = await af.read(length);
    return ret;
  }

  @override
  Future<int> getLength() async {
    return af.length();
  }

  @override
  Future<int> truncate(int fileSize) async {
    int s = await getLength();
    if(fileSize >= s) {
      return s;
    }
    await af.truncate(fileSize);
    int ret = await getLength();
    return ret;
  }
}