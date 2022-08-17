import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/utils/mlog.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebView extends StatefulWidget {
  MyWebView(this.url, {Key? key}) : super(key: key);

  final String url;
  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),

    /// android 支持HybridComposition
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  Future<void> checkCookie(Uri cookie) async {
    CookieManager cookieManager = CookieManager.instance();
    List<String> names = ['datr','sb','m_pixel_ratio','fr','c_user','cx','wd'];
    Map<String,String> cookieStr = Map();
    String result = "";

    for (var value in names) {
      Cookie? c = await cookieManager.getCookie(url: cookie,name:value) ;

      if(c != null ){
        result+= "${c.name}=${c.value};";
      }
    }

    logger.e(json.encode(cookieStr));
    logger.e( result);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            initialOptions: options,
            onLoadStop: (controller, url) async => {checkCookie(url!!)}));
  }
}
