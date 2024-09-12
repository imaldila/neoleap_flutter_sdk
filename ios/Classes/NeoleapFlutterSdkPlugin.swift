import Flutter
import UIKit
#if !targetEnvironment(simulator)
import mPOSSDK
#endif


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
#if !targetEnvironment(simulator)
        case "connect":
            MPOSService.service.connect(onSuccess: { (status, response) in
                result("Connected successfully")
            }) { (status) in
                result(FlutterError(code: "CONNECT_FAILED", message: "Failed to connect", details: nil))
            }
        case "disconnect":
            MPOSService.service.disconnect(onSuccess: { (status, response) in
                result("Disconnected successfully")
            }) { (status) in
                result(FlutterError(code: "DISCONNECT_FAILED", message: "Failed to disconnect", details: nil))
            }
        case "cancelTransaction":
            MPOSService.service.cancelTransaction(onSuccess: { (status, response) in
                result("Transaction cancelled successfully")
            }) { (status) in
                result(FlutterError(code: "CANCEL_FAILED", message: "Failed to cancel transaction", details: nil))
            }
        case "startTransaction":
            guard let args = call.arguments as? [String: Any],
                  let xmlRequest = args["xmlRequest"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for startTransaction", details: nil))
                return
            }
            MPOSService.service.startTransaction(xmlRequest, onSuccess: { (status, response) in
                result(response)
            }) { (status) in
                result(FlutterError(code: "TRANSACTION_FAILED", message: "Transaction failed", details: nil))
            }
        case "getLastTransactionResult":
            MPOSService.service.getLastTransactionResult(onSuccess: { (status, response) in
                result(response)
            }) { (status) in
                result(FlutterError(code: "GET_LAST_TRANSACTION_FAILED", message: "Failed to get last transaction result", details: nil))
            }
        case "getLastReconciliationResult":
            MPOSService.service.getLastReconciliationResult(onSuccess: { (status, response) in
                result(response)
            }) { (status) in
                result(FlutterError(code: "GET_LAST_RECONCILIATION_FAILED", message: "Failed to get last reconciliation result", details: nil))
            }
        case "getTerminalData":
            MPOSService.service.getTerminalData(onSuccess: { (status, response) in
                result(response)
            }) { (status) in
                result(FlutterError(code: "GET_TERMINAL_DATA_FAILED", message: "Failed to get terminal data", details: nil))
            }
        case "checkExistence":
            MPOSService.service.checkExistence(onSuccess: { (status, response) in
                result(true)
            }) { (status) in
                result(false)
            }
        case "setLanguage":
            guard let args = call.arguments as? [String: Any],
                  let language = args["language"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for setLanguage", details: nil))
                return
            }
            MPOSService.service.setLanguage(language: language, onSuccess: { (status, response) in
                result("Language set successfully")
            }) { (status) in
                result(FlutterError(code: "SET_LANGUAGE_FAILED", message: "Failed to set language", details: nil))
            }
        case "setMenuStatus":
            guard let args = call.arguments as? [String: Any],
                  let menuStatus = args["menuStatus"] as? Bool else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for setMenuStatus", details: nil))
                return
            }
            MPOSService.service.setMenuStatus(menuStatus: menuStatus, onSuccess: { (status, response) in
                result("Menu status set successfully")
            }) { (status) in
                result(FlutterError(code: "SET_MENU_STATUS_FAILED", message: "Failed to set menu status", details: nil))
            }
            
#else
        case "connect", "disconnect", "cancelTransaction", "startTransaction",
            "getLastTransactionResult", "getLastReconciliationResult",
            "getTerminalData", "checkExistence", "setLanguage", "setMenuStatus":
            result(FlutterError(code: "UNAVAILABLE", message: "mPOSSDK is not available in the simulator", details: nil))
#endif
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
}
