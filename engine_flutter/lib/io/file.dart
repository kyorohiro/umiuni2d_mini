part of io_flutter;

class TinyFlutterFile extends io.File {
  dio.File f;
  TinyFlutterFile(this.f) {
    ;
  }

  Future<Object> init() async {
    if(await f.exists() == false) {
      await f.create(recursive: true);
    }
  }

  @override
  Future<int> writeAsBytes(List<int> buffer, int offset) async {
    await init();
    dio.RandomAccessFile af = await f.open(mode: dio.FileMode.WRITE);
    await af.setPosition(offset);
    await af.writeFrom(buffer);
    await af.close();
    return buffer.length;
  }

  @override
  Future<List<int>> readAsBytes(int offset, int length) async {
    await init();
    dio.RandomAccessFile af = await f.open();
    await af.setPosition(offset);
    List<int> ret = await af.read(length);
    await af.close();
    return ret;
  }

  @override
  Future<int> getLength() async {
    await init();
    return f.length();
  }

  @override
  Future<int> truncate(int fileSize) async {
    await init();
    int s = await getLength();
    if(fileSize >= s) {
      return s;
    }
    dio.RandomAccessFile af = await f.open();
    await af.truncate(fileSize);
    int ret = await getLength();
    await af.close();
    return ret;
  }
}