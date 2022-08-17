package com.example.flutter_camera

import android.content.Context
import android.graphics.Color
import android.view.View
import android.webkit.WebView
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.BinaryMessenger
internal class FWebview(context: Context, messenger: BinaryMessenger, viewId: Int, args: Map<String, Any>?) : PlatformView {
    private val webView: WebView

    override fun getView(): View {
        return webView
    }

    override fun dispose() {}

    init {
        webView = WebView(context)
        webView.loadUrl("https://www.baidu.com")
    }
}
