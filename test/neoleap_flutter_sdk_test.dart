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

  @override
  // Future<Map<String, dynamic>> connectMPOS() => Future.value({});

  @override
  Future<String?> cancelTransaction() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> checkExistence() {
    throw UnimplementedError();
  }

  @override
  Future<String?> connect() {
    throw UnimplementedError();
  }

  @override
  Future<String?> disconnect() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getLastReconciliationResult() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getLastTransactionResult() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> getTerminalData() {
    throw UnimplementedError();
  }

  @override
  Future<String?> setLanguage() {
    throw UnimplementedError();
  }

  @override
  Future<String?> setMenuStatus() {
    throw UnimplementedError();
  }

  @override
  Future<String?> startTransaction(String xmlRequest) {
    throw UnimplementedError();
  }
  
  @override
  Future<String?> connectToDevice() {
    throw UnimplementedError();
  }
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

  // test('connectMPOS', () async {
  //   NeoleapFlutterSdk neoleapFlutterSdkPlugin = NeoleapFlutterSdk();
  //   MockNeoleapFlutterSdkPlatform fakePlatform =
  //       MockNeoleapFlutterSdkPlatform();
  //   NeoleapFlutterSdkPlatform.instance = fakePlatform;

  //   expect(await neoleapFlutterSdkPlugin.connectMPOS(), {});
  // });
}
