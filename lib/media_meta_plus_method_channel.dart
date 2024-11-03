import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:media_meta_plus/src/model/meta_data.dart';
import 'media_meta_plus_platform_interface.dart';


/// An implementation of [MediaMetaPlusPlatform] that uses method channels.
class MethodChannelMediaMetaPlus extends MediaMetaPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('media_meta_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Metadata> fromFile(String path) async {
    final metadata = await methodChannel.invokeMethod<Map>('fromFile', {'filePath': path});
    return Metadata.fromJson(metadata!);
  }
}
