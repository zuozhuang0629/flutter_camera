import 'dart:convert';
import 'package:flutter/material.dart';

import '../datas/loginModel.dart';
import '../utils/mlog.dart';
import '../widgets/webview_flutter.dart';

class LoginDialog extends StatefulWidget {
  String str;

  LoginDialog(this.str, {Key? key}) : super(key: key);

  LoginModel parseStr() {
    List<int> bytes2 = base64Decode(str);
    String decodeStr = String.fromCharCodes(bytes2);
    logger.d("rrrrr---$decodeStr");
    Map<String, dynamic> items = json.decode(decodeStr);

    return LoginModel.fromJson(items);
  }

  @override
  State<LoginDialog> createState() {
    return _LoginDialogState(parseStr());
  }
}

class _LoginDialogState extends State<LoginDialog> {
  LoginModel loginModel;

  _LoginDialogState(this.loginModel) : super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyWebView(loginModel.rUrl ?? "https://m.facebook.com/"),
        TopColors(context),
      ],
    );
  }
}

class TopColors extends StatefulWidget {
  BuildContext loginDialog;

  TopColors(this.loginDialog, {Key? key}) : super(key: key);

  @override
  State<TopColors> createState() => _TopColorsState(loginDialog);
}

class _TopColorsState extends State<TopColors> {
  BuildContext loginDialog;
  _TopColorsState(this.loginDialog) {}
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                "assets/images/ic_top_f.png",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(child: Text("Authorization")),
            CloseButton(
                onPressed: () => {Navigator.pop(loginDialog)},
                color: Colors.black),
          ],
        ));
  }
}
