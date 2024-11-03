// import 'package:flutter_test/flutter_test.dart';
// import 'package:media_meta_plus/media_meta_plus.dart';
// import 'package:media_meta_plus/media_meta_plus_platform_interface.dart';
// import 'package:media_meta_plus/media_meta_plus_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockMediaMetaPlusPlatform
//     with MockPlatformInterfaceMixin
//     implements MediaMetaPlusPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final MediaMetaPlusPlatform initialPlatform = MediaMetaPlusPlatform.instance;
//
//   test('$MethodChannelMediaMetaPlus is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelMediaMetaPlus>());
//   });
//
//   test('getPlatformVersion', () async {
//     MediaMetaPlus mediaMetaPlusPlugin = MediaMetaPlus();
//     MockMediaMetaPlusPlatform fakePlatform = MockMediaMetaPlusPlatform();
//     MediaMetaPlusPlatform.instance = fakePlatform;
//
//     expect(await mediaMetaPlusPlugin.getPlatformVersion(), '42');
//   });
// }
