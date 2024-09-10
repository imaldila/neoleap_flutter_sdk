import Flutter
import UIKit
import mPOSSDK


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
        case "connectMPOS":
           connectMPOS(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func connectMPOS(result: @escaping FlutterResult) {
        MPOSService.service.connect(onSuccess: {(status, mposResult) in
            let response = [
                "status": "success",
                "description": status.description
            ]
            result(response)
        }, onFailure: {(status) in
            let response = [
                "status": "failure",
                "description": status.description
            ]
            result(response)
        })
    }
}
