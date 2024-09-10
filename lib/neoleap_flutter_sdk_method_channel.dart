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
  Future<Map<String, dynamic>?> connectMPOS() async {
    final Map<String, dynamic> result =
        await methodChannel.invokeMethod('connectMPOS');
    return result;
  }

  @override
  Future<String?> connect() async {
    final String? result = await methodChannel.invokeMethod('connect');
    return result;
  }

  @override
  Future<String?> disconnect() async {
    final String? result = await methodChannel.invokeMethod('disconnect');
    return result;
  }

  @override
  Future<String?> cancelTransaction() async {
    final String? result =
        await methodChannel.invokeMethod('cancelTransaction');
    return result;
  }

  @override
  Future<String?> startTransaction(String xmlRequest) async {
    final String? result = await methodChannel
        .invokeMethod('startTransaction', {'xmlRequest': xmlRequest});
    return result;
  }

  @override
  Future<String?> getLastTransactionResult() async {
    final String? result =
        await methodChannel.invokeMethod('getLastTransactionResult');
    return result;
  }

  @override
  Future<String?> getLastReconciliationResult() async {
    final String? result =
        await methodChannel.invokeMethod('getLastReconciliationResult');
    return result;
  }

  @override
  Future<Map<String, dynamic>?> getTerminalData() async {
    final Map<String, dynamic> result =
        await methodChannel.invokeMethod('getTerminalData');
    return result;
  }

  @override
  Future<bool?> checkExistence() async {
    final bool? result = await methodChannel.invokeMethod('checkExistence');
    return result;
  }

  @override
  Future<String?> setLanguage({String? language}) async {
    final String? result =
        await methodChannel.invokeMethod('setLanguage', {'language': language});
    return result;
  }

  @override
  Future<String?> setMenuStatus({bool? menuStatus}) async {
    final String? result = await methodChannel
        .invokeMethod('setMenuStatus', {'menuStatus': menuStatus});
    return result;
  }
}
