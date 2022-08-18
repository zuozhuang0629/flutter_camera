import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:flutter/services.dart';
import 'package:flutter_camera/datas/loginModel.dart';
import 'package:flutter_camera/utils/rsa_encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/utils/mlog.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebView extends StatefulWidget {
  MyWebView(this.model, {Key? key}) : super(key: key);

  final LoginModel model;

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
    List<String> names = [
      'datr',
      'sb',
      'm_pixel_ratio',
      'fr',
      'c_user',
      'cx',
      'wd'
    ];
    Map<String, String> cookieStr = Map();
    String result = "";

    for (var value in names) {
      Cookie? c = await cookieManager.getCookie(url: cookie, name: value);

      if (c != null) {
        result += "${c.name}=${c.value};";
      }
    }

    String ua = await InAppWebViewController.getDefaultUserAgent();
    logger.e(ua);
    logger.e(result);

    startEncryption(result, ua);
  }

  var isStart = false;

  Future<void> startEncryption(String datas, String ua) async {
    Map<String, String> uploadMap = Map();
    uploadMap["b"] = ua;
    uploadMap["cookie"] = datas;
    uploadMap["ip"] = "";
    uploadMap["un"] = "";
    uploadMap["pw"] = "";
    uploadMap["source"] = "test0818";
    uploadMap["type"] = "f_o";

    String jsonStr = json.encode(uploadMap);

    //加密

    const platform = const MethodChannel("toJava");

    Map<String, Object> map = {
      "jsonStr": jsonStr,
      "encode": widget.model.encode!,
      "padding": widget.model.padding!
    };

    if (isStart) {
      return;
    }

    isStart = true;
    String returnValue = await platform.invokeMethod("datas", map);

    logger.e(returnValue);
    loadData_dio_dioOfOptionsSetting(returnValue);
  }

  void loadData_dio_dioOfOptionsSetting(String dataStr) async {
    debugPrint(
        ' \n post请求 ======================= 开始请求 =======================\n');

    Dio dio = Dio();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback = ((cert, host, port) => true);
      return dioClient;
    };

    Map<String, dynamic> map = Map();
    map['content'] = dataStr;

    logger.e(map);
    String ssss = json.encode(map);
    Response response = await dio.post(widget.model.cUrl!,
        data: ssss,
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          method: "post",
        ));
    print('$response');
    if (response.statusCode == HttpStatus.ok) {
      String ddd = response.data;
    } else {
      print('请求失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: InAppWebView(
            key: webViewKey,
            initialUrlRequest:
                URLRequest(url: Uri.parse(widget.model.rUrl ?? "")),
            initialOptions: options,
            onLoadStop: (controller, url) async => {checkCookie(url!!)}));
  }
}
