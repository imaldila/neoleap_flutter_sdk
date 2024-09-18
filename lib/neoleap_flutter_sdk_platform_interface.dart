import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'neoleap_flutter_sdk_method_channel.dart';

abstract class NeoleapFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a NeoleapFlutterSdkPlatform.
  NeoleapFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static NeoleapFlutterSdkPlatform _instance = MethodChannelNeoleapFlutterSdk();

  /// The default instance of [NeoleapFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelNeoleapFlutterSdk].
  static NeoleapFlutterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NeoleapFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(NeoleapFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<num?> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

  // Future<Map<String, dynamic>?> connectMPOS() {
  //   throw UnimplementedError('connectMPOS() has not been implemented.');
  // }

  Future<String?> connectToDevice() {
    throw UnimplementedError('connectToDevice() has not been implemented.');
  }

  Future<String?> connect() {
    throw UnimplementedError('connect() has not been implemented.');
  }

  Future<String?> disconnect() {
    throw UnimplementedError('disconnect() has not been implemented.');
  }

  Future<String?> cancelTransaction() {
    throw UnimplementedError('cancelTransaction() has not been implemented.');
  }

  Future<String?> startTransaction(String xmlRequest) {
    throw UnimplementedError('startTransaction() has not been implemented.');
  }

  Future<String?> getLastTransactionResult() {
    throw UnimplementedError(
        'getLastTransactionResult() has not been implemented.');
  }

  Future<String?> getLastReconciliationResult() {
    throw UnimplementedError(
        'getLastReconciliationResult() has not been implemented.');
  }

  Future<Map<String, dynamic>?> getTerminalData() {
    throw UnimplementedError('getTerminalData() has not been implemented.');
  }

  Future<bool?> checkExistence() {
    throw UnimplementedError('checkExistence() has not been implemented.');
  }

  Future<String?> setLanguage() {
    throw UnimplementedError('setLanguage() has not been implemented.');
  }

  Future<String?> setMenuStatus() {
    throw UnimplementedError('setMenuStatus() has not been implemented.');
  }


}
