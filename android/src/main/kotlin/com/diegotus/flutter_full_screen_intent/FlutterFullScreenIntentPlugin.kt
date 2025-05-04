package com.diegotus.flutter_full_screen_intent

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterFullScreenIntentPlugin */
class FlutterFullScreenIntentPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_full_screen_intent")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "openFullScreenWidget") {
      val route = call.arguments as? String
      if (route.isNullOrBlank()) {
          result.error("INVALID_ARGUMENT", "Route is required and must be a non-empty string.", null)
          return false;
      }
      try {
          openFullScreenWidget(route)
          result.success(true)
      } catch (e: Exception) {
          Log.e("FullScreenIntentPlugin", "Failed to open full screen widget", e)
          result.error("LAUNCH_FAILED", "Failed to open full screen widget: ${e.message}", false)
          
      }
    } else {
      result.notImplemented()
    }
  }

  
  private fun openFullScreenWidget(route: String) {
    val intent = FlutterActivity
        .withCachedEngine("fullScreenIntentPlugin_diego")
        .initialRoute(route)
        .build(context)

    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    context.startActivity(intent)

    Log.d("FullScreenIntentPlugin", "Started FlutterActivity with cached engine and route: $route")
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
