package com.okjl.a_cameras

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class CamerasPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val instance = CamerasPlugin()
            instance.context = registrar.context()

            // Register the main channel
            val channel = MethodChannel(registrar.messenger(), "cameras")
            channel.setMethodCallHandler(instance)
            instance.channel = channel
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        // Initialize the main channel
        channel = MethodChannel(binding.binaryMessenger, "cameras")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "getPlatformType" -> result.success("android")
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
