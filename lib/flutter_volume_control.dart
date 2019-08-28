import 'dart:async';

import 'package:flutter/services.dart';

class FlutterVolumeControl {
  static const MethodChannel _channel =
      const MethodChannel('flutter_volume_control');

  static Future<String> getVolume() async {
    final String volume =
    await _channel.invokeMethod('getVolume');
    return volume;
  }

  static Future<String> setVolumeLarge() async {
    final String volume =
    await _channel.invokeMethod('setVolumeLarge');
    return volume;
  }

  static Future<String> setVolumeSmall() async {
    final String volume =
    await _channel.invokeMethod('setVolumeSmall');
    return volume;
  }

}
