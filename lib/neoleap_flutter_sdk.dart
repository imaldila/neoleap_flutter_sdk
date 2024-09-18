import 'neoleap_flutter_sdk_platform_interface.dart';

class NeoleapFlutterSdk {
  Future<String?> getPlatformVersion() {
    return NeoleapFlutterSdkPlatform.instance.getPlatformVersion();
  }

  /// Returns the battery level of the device.
  Future<num?> getBatteryLevel() {
    return NeoleapFlutterSdkPlatform.instance.getBatteryLevel();
  }

  // Future<Map<String, dynamic>?> connectMPOS() {
  //   return NeoleapFlutterSdkPlatform.instance.connectMPOS();
  // }

  Future<String?> connect() {
    return NeoleapFlutterSdkPlatform.instance.connect();
  }

  Future<String?> connectToDevice() {
    return NeoleapFlutterSdkPlatform.instance.connectToDevice();
  }

  Future<String?> disconnect() {
    return NeoleapFlutterSdkPlatform.instance.disconnect();
  }

  Future<String?> cancelTransaction() {
    return NeoleapFlutterSdkPlatform.instance.cancelTransaction();
  }

  Future<String?> startTransaction(String xmlRequest) {
    return NeoleapFlutterSdkPlatform.instance.startTransaction(xmlRequest);
  }

  Future<String?> getLastTransactionResult() {
    return NeoleapFlutterSdkPlatform.instance.getLastTransactionResult();
  }

  Future<String?> getLastReconciliationResult() {
    return NeoleapFlutterSdkPlatform.instance.getLastReconciliationResult();
  }

  Future<Map<String, dynamic>?> getTerminalData() {
    return NeoleapFlutterSdkPlatform.instance.getTerminalData();
  }

  Future<bool?> checkExistence() {
    return NeoleapFlutterSdkPlatform.instance.checkExistence();
  }

  Future<String?> setLanguage() {
    return NeoleapFlutterSdkPlatform.instance.setLanguage();
  }

  Future<String?> setMenuStatus() {
    return NeoleapFlutterSdkPlatform.instance.setMenuStatus();
  }
}
