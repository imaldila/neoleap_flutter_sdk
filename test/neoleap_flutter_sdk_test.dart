import 'package:flutter_test/flutter_test.dart';
import 'package:neoleap_flutter_sdk/neoleap_flutter_sdk.dart';
import 'package:neoleap_flutter_sdk/neoleap_flutter_sdk_method_channel.dart';
import 'package:neoleap_flutter_sdk/neoleap_flutter_sdk_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNeoleapFlutterSdkPlatform
    with MockPlatformInterfaceMixin
    implements NeoleapFlutterSdkPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<num?> getBatteryLevel() => Future.value(21);
}

void main() {
  final NeoleapFlutterSdkPlatform initialPlatform =
      NeoleapFlutterSdkPlatform.instance;

  test('$MethodChannelNeoleapFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNeoleapFlutterSdk>());
  });

  test('getPlatformVersion', () async {
    NeoleapFlutterSdk neoleapFlutterSdkPlugin = NeoleapFlutterSdk();
    MockNeoleapFlutterSdkPlatform fakePlatform =
        MockNeoleapFlutterSdkPlatform();
    NeoleapFlutterSdkPlatform.instance = fakePlatform;

    expect(await neoleapFlutterSdkPlugin.getPlatformVersion(), '42');
  });

  test('getBatteryLevel', () async {
    NeoleapFlutterSdk neoleapFlutterSdkPlugin = NeoleapFlutterSdk();
    MockNeoleapFlutterSdkPlatform fakePlatform =
        MockNeoleapFlutterSdkPlatform();
    NeoleapFlutterSdkPlatform.instance = fakePlatform;

    expect(await neoleapFlutterSdkPlugin.getBatteryLevel(), 21);
  });
  
}
