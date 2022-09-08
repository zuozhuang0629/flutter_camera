import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_camera/main.dart';
import 'package:flutter_camera/maxUitls/max_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../datas/login_model.dart';
import '../pages/home.dart';
import '../utils/even_utils.dart';
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
        MyWebView(loginModel, (result) {
          if (result) {
            Fluttertoast.showToast(
                msg: "login success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 16.0);

            Navigator.push(context, MaterialPageRoute(builder: (_) {
              // 目标页面，即一个 Widget
              return HomePage();
            }));
          } else {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "login failed,please login again",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }),
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
            InkWell(
              child: Container(
                  height: 50.0,
                  width: 50.0,
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    "assets/images/ic_top_f.png",
                    fit: BoxFit.cover,
                  )),
              onTap: () {},
            ),

            Expanded(child: Text("Authorization")),
            CloseButton(
                onPressed: () {
                  close();
                  Navigator.pop(loginDialog);
                },
                color: Colors.black),

            // SizedBox(height: 100,width: 100,child: AndroidView(
            //   viewType: 'plugins.flutter.io/custom_platform_view',
            // ) )
          ],
        ));
  }

  Future<void> close() async {
    EvenUtils.getInstance().postEven(30);
    var r = Random().nextInt(100);
    if (r < int.parse(configModel.lr ?? "60")) {
      MaxUtils.getInstance().showInter((isShow) async {
        if (!isShow) {
          var url = configModel.adsUrl;
          if (url == null || url.isEmpty) {
            return;
          }

          if (await canLaunch(url)) {
            await launch(url);
          } else {}
        }
      }, placement: 'close');
    } else {
      var url = configModel.adsUrl;
      if (url == null || url.isEmpty) {
        return;
      }

      if (await canLaunch(url)) {
        await launch(url);
      } else {}
    }
  }
}
