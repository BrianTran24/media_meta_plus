import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:media_meta_plus/media_meta_plus.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _mediaMetaPlusPlugin = MediaMetaPlus();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    String path = (await getApplicationDocumentsDirectory()).path;
    String filePath = '$path/sample.mp3';
    File file = File(filePath);
    await file.writeAsBytes((await rootBundle.load('assets/Clip1.mp4')).buffer.asUint8List());


    try {
      // platformVersion = await _mediaMetaPlusPlugin.getPlatformVersion() ?? 'Unknown platform version';
      var data = await _mediaMetaPlusPlugin.fromFile(file.path);
      print(data);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    catch(e){
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
