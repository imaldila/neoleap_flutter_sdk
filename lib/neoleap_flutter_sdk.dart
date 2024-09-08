
import 'neoleap_flutter_sdk_platform_interface.dart';

class NeoleapFlutterSdk {
  Future<String?> getPlatformVersion() {
    return NeoleapFlutterSdkPlatform.instance.getPlatformVersion();
  }

  /// Returns the battery level of the device.
  Future<num?> getBatteryLevel() {
    return NeoleapFlutterSdkPlatform.instance.getBatteryLevel();
  }

  
}
