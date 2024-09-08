import Flutter
import UIKit

public class NeoleapFlutterSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "neoleap_flutter_sdk", binaryMessenger: registrar.messenger())
        let instance = NeoleapFlutterSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "getBatteryLevel":
            UIDevice.current.isBatteryMonitoringEnabled = true
            
            result(UIDevice.current.batteryLevel * 100)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
}
