package com.example.neoleap_flutter_sdk

import android.content.Context
import android.os.BatteryManager
import android.os.Build

import androidx.annotation.NonNull;
import com.mpos.mpossdk.api.MPOSService
import com.mpos.mpossdk.api.MPOSServiceCallback

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NeoleapFlutterSdkPlugin */
class NeoleapFlutterSdkPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var batteryManager: BatteryManager // add this line
  private lateinit var mposService: MPOSService

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "neoleap_flutter_sdk")
    channel.setMethodCallHandler(this)
    mposService = MPOSService.getInstance(flutterPluginBinding.applicationContext)
    batteryManager = flutterPluginBinding.applicationContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "getBatteryLevel" -> {
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP ) {
          result.success(batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY))
        }
      }
      "connectToDevice" -> {
        mposService.connectToDevice(object : MPOSServiceCallback {
          override fun onComplete(statusCode: Int, message: String,resultObj: Any?) {
            result.success(true)
          }
          override fun onFailed(statusCode: Int, message: String) {
            result.error("CONNECT_FAILED", message, null)
          }
        })
      }
      "stopService" -> {
        mposService.stop()
        result.success(null)
      }
      "cancelTransaction" -> {
        mposService.cancelTransaction()
        result.success(null)
      }
      "startTransaction" -> {
        val xmlRequest = call.argument<String>("xmlRequest")
        if (xmlRequest != null) {
          mposService.startTransaction(xmlRequest, object : MPOSServiceCallback {
            override fun onComplete(statusCode: Int, message: String, resultObj: Any?) {
              val xmlResponse = result as String
              val responseMap = mposService.parseTransactionResponse(xmlResponse)
              result.success(responseMap)
            }
            override fun onFailed(statusCode: Int, message: String) {
              result.error("TRANSACTION_FAILED", message, null)
            }
          })
        } else {
          result.error("INVALID_ARGUMENT", "xmlRequest is required", null)
        }
      }
      "getLastTransactionResult" -> {
        mposService.getLastTransactionResult(object : MPOSServiceCallback {
          override fun onComplete(statusCode: Int, message: String, resultObj: Any?) {
            val xmlResponse = result as String
            val responseMap = mposService.parseTransactionResponse(xmlResponse)
            result.success(responseMap)
          }
          override fun onFailed(statusCode: Int, message: String) {
            result.error("GET_LAST_TRANSACTION_FAILED", message, null)
          }
        })
      }
      "sendDigitalReceipt" -> {
        val phoneNumber = call.argument<String>("phoneNumber")
        val email = call.argument<String>("email")
        val completeResponse = call.argument<String>("completeResponse")
        if (phoneNumber != null && email != null && completeResponse != null) {
          mposService.sendDigitalReceipt(phoneNumber, email, completeResponse, object : MPOSServiceCallback {
            override fun onComplete(statusCode: Int, message: String, resultObj: Any?) {
              result.success(true)
            }
            override fun onFailed(statusCode: Int, message: String) {
              result.error("SEND_DIGITAL_RECEIPT_FAILED", message, null)
            }
          })
        } else {
          result.error("INVALID_ARGUMENT", "phoneNumber, email, and completeResponse are required", null)
        }
      }

      "setLanguage" -> {
        val language = call.argument<String>("language")
        if (language != null) {
          mposService.setLanguage(language, object : MPOSServiceCallback {
            override fun onComplete(statusCode: Int, message: String, resultObj: Any?) {
              result.success(true)
            }
            override fun onFailed(statusCode: Int, message: String) {
              result.error("SET_LANGUAGE_FAILED", message, null)
            }
          })
        } else {
          result.error("INVALID_ARGUMENT", "language is required", null)
        }
      }
      "setMenuStatus" -> {
        val showMenu = call.argument<Boolean>("showMenu")
        if (showMenu != null) {
          mposService.setMenuStatus(showMenu, object : MPOSServiceCallback {
            override fun onComplete(statusCode: Int, message: String, resultObj: Any?) {
              result.success(true)
            }
            override fun onFailed(statusCode: Int, message: String) {
              result.error("SET_MENU_STATUS_FAILED", message, null)
            }
          })
        } else {
          result.error("INVALID_ARGUMENT", "showMenu is required", null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
