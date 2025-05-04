package com.diegotus.flutter_full_screen_intent

import android.content.Context
import android.content.Intent
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterFullScreenIntentPlugin */
class FlutterFullScreenIntentPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context // Added context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_full_screen_intent")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext // Initialize context
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "openFullScreenWidget" -> {
                val route = call.argument<String>("route") // Use argument<String>
                if (route.isNullOrBlank()) {
                    result.error(
                        "INVALID_ARGUMENT",
                        "Route is required and must be a non-empty string.",
                        null
                    )
                    return  // Important: Return after error
                }
                try {
                    openFullScreenWidget(route)
                    result.success(true)
                } catch (e: Exception) {
                    Log.e("FlutterFullScreenIntentPlugin", "Failed to open full screen widget", e)
                    result.error("LAUNCH_FAILED", "Failed to open full screen widget: ${e.message}", null)
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun openFullScreenWidget(route: String) {
        try {
            val intent = FlutterActivity
                .withNewEngine()
                .initialRoute(route)
                .build(context)

            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
            Log.d("FullScreenIntentPlugin", "Started FlutterActivity with route: $route")
        } catch (e: Exception) {
            Log.e("FullScreenIntentPlugin", "Error starting activity", e) // Log the error
            throw e // Re-throw the exception so it's caught in onMethodCall
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}