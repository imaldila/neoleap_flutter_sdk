package com.example.neoleap_flutter_sdk

import android.content.Context
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull

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

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "neoleap_flutter_sdk")
    channel.setMethodCallHandler(this)
    
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
      else -> {
        result.notImplemented()
      }
    }

  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
