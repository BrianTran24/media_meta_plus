import 'package:flutter/src/widgets/basic.dart';
import 'package:media_meta_plus/src.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'media_meta_plus_method_channel.dart';

abstract class MediaMetaPlusPlatform extends PlatformInterface {
  /// Constructs a MediaMetaPlusPlatform.
  MediaMetaPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static MediaMetaPlusPlatform _instance = MethodChannelMediaMetaPlus();

  /// The default instance of [MediaMetaPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelMediaMetaPlus].
  static MediaMetaPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MediaMetaPlusPlatform] when
  /// they register themselves.
  static set instance(MediaMetaPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Metadata> fromFile(String path) {
    throw UnimplementedError('fromFile() has not been implemented.');
  }
}
