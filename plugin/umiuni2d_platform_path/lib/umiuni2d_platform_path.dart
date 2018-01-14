import 'dart:async';

import 'package:flutter/services.dart';

class Umiuni2dPlatformPath {
  MethodChannel _channel;

  Umiuni2dPlatformPath() {
    _channel = const MethodChannel('umiuni2d_platform_path');
  }

  Future<String> getCacheDirectory({String defaultPath:"/"}) async {
    String path = await _channel.invokeMethod("getCacheDirectory");
    if(path == null) {
      return defaultPath;
    } else {
      return path;
    }
  }

  Future<String> getApplicationDirectory({String defaultPath:"/"}) async {
    String path = await _channel.invokeMethod("getApplicationDirectory");
    if(path == null) {
      return defaultPath;
    } else {
      return path;
    }
  }

  Future<String> getDocumentDirectory({String defaultPath:"/"}) async {
    String path = await _channel.invokeMethod("getDocumentDirectory");
    if(path == null) {
      return defaultPath;
    } else {
      return path;
    }
  }


}
