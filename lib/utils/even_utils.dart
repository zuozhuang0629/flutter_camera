import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class EvenUtils {
  static EvenUtils? _instance;

  // 私有的命名构造函数
  EvenUtils._internal();

  static EvenUtils getInstance() {
    _instance ??= EvenUtils._internal();

    return _instance!;
  }

  void postEven(int type) async {
    try {
      var url = Uri.https('blackunaex.store', 'dot/data');
      const platform = const MethodChannel("getGaid");

      var gaid = await platform.invokeMethod("id");
      var body  = jsonEncode({
        'appName': 'Colguy Cam Proxy',
        'eventType': '$type',
        'gia': '$gaid',
        'operationTime': '${DateTime.now().millisecondsSinceEpoch}'
      });


      var response = await http.post(url, body: body);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      print('打点返回结果: ${decodedResponse}');

    } catch (e) {
      print('打点错误: ${e}');
    }
  }
}
