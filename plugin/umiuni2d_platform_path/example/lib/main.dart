import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umiuni2d_platform_path/umiuni2d_platform_path.dart';

import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = 'Unknown';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await new Future.delayed(new Duration(seconds: 1));
    String message = "";
    Umiuni2dPlatformPath path = new Umiuni2dPlatformPath();
    if(path == null){
      message = "path == NULL";
    } else {
      try {
        message += "#AppDir# ${await path
            .getApplicationDirectory()}\r\n";
        message += "#DocDir# ${await path
            .getDocumentDirectory()}\r\n";
        message += "#TmpDir# ${await path.getCacheDirectory()}\r\n";
      } on PlatformException {
        message = 'Failed to get platform version.';
      } catch (e) {}
    }

    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('$_message\n'),
        ),
      ),
    );
  }
}
