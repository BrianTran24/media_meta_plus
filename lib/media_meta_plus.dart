
import 'package:flutter/cupertino.dart';
import 'package:media_meta_plus/src/model/meta_data.dart';

import 'media_meta_plus_platform_interface.dart';

class MediaMetaPlus {
  Future<String?> getPlatformVersion() {
    return MediaMetaPlusPlatform.instance.getPlatformVersion();
  }

  Future<Metadata> fromFile(String path) {
    return MediaMetaPlusPlatform.instance.fromFile(path);
  }
}
