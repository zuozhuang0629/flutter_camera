import 'package:flutter/material.dart';

import '../widgets/webview_flutter.dart';

class LoginDialog extends Dialog {
  LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency, //透明类型
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              MyWebView("https://m.facebook.com/"),
              TopColors(context),
            ],
          ),
        ));
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
