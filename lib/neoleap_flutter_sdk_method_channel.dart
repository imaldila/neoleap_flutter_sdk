import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'neoleap_flutter_sdk_platform_interface.dart';

/// An implementation of [NeoleapFlutterSdkPlatform] that uses method channels.
class MethodChannelNeoleapFlutterSdk extends NeoleapFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('neoleap_flutter_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<num?> getBatteryLevel() async {
    final batteryLevel =
        await methodChannel.invokeMethod<num>('getBatteryLevel');
    return batteryLevel;
  }

  @override
  Future<Map<String,dynamic>> connectMPOS() async {
    final Map<String, dynamic> result = await methodChannel.invokeMethod('connectMPOS');
    return result;
  }
}
