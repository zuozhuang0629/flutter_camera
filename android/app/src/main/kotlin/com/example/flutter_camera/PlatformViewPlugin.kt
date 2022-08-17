package com.example.flutter_camera


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry


class PlatformViewPlugin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        val messenger: BinaryMessenger = binding.binaryMessenger
        binding
            .platformViewRegistry
            .registerViewFactory("plugins.flutter.io/custom_platform_view", FWebViewFactory(messenger))
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            registrar
                .platformViewRegistry()
                .registerViewFactory(
                    "plugins.flutter.io/custom_platform_view",
                    FWebViewFactory(registrar.messenger()))
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}
}
