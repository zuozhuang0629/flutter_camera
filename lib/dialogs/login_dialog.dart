import 'package:flutter/material.dart';

class LoginDialog extends Dialog {
  LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency, //透明类型
        child: Container(
          color: Colors.black54,
          child: Column(children: <Widget>[TopColors()]),
        ));
  }
}

class TopColors extends StatefulWidget {
  TopColors({Key? key}) : super(key: key);

  @override
  State<TopColors> createState() => _TopColorsState();
}

class _TopColorsState extends State<TopColors> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Image.asset("assets/images/bg_sell.png", height: 50.0),
            Text("sssss")
          ],
        ));
  }
}
