import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter_camera/datas/configModel.dart';
import 'package:flutter_camera/dialogs/login_dialog.dart';
import 'package:flutter_camera/pages/home.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_camera/widgets/image_click.dart';

void main() {
  runApp(const MyApp());
}

String _banner_ad_unit_id = "10424d6678069178";

void initializeBannerAds() {
  AppLovinMAX.createBanner(_banner_ad_unit_id, AdViewPosition.bottomCenter);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _active = false;
  @override
  void initState() {
    super.initState();
    initializePlugin();
    getHttp();
  }

  Future<void> initializePlugin() async {
    logStatus("Initializing SDK...");

    Map? configuration = await AppLovinMAX.initialize(
        "RH7xIMirQp-k9XpQo6fmPQgzvCNPd1VTpxsoG4eyyoz2-fkg4HgvP7tWttcTng2iC9vnT4Mvp7Gi_69V2xZxPX");
    if (configuration != null) {
      logStatus("SDK Initialized: $configuration");
      initializeBannerAds();

      AppLovinMAX.showBanner(_banner_ad_unit_id);
    }
  }

  void logStatus(String status) {
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(alignment: Alignment.center, children: <Widget>[
          SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Image.asset(
              "assets/images/bg_sell.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 60.0,
            child: InkWell(
              // When the user taps the button, show a snackbar.
              onTap: () {
                AppLovinMAX.hideBanner(_banner_ad_unit_id);
                showLoginDialog();
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Opacity(
                      opacity: 1.0,
                      child: Image.asset("assets/images/ic_bb_op.png",
                          height: 100.0),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Future<bool?> showLoginDialog() {
  //   return showDialog<bool>(

  //     context: context,
  //     builder: (context) {
  //       return LoginDialog();
  //     },
  //   );
  // }
// Future<bool?> showLoginDialog() {
//     return showModalBottomSheet<bool>(
//         context: context,
//         builder: (context) {
//           return AnimatedPadding(
//             padding: MediaQuery.of(context).viewInsets,
//             duration: const Duration(milliseconds: 100),
//             child: LoginDialog(),
//           );
//         });
//   }
  Future<bool?> showLoginDialog() {
    // return showDialog(
    //     context: context,
    //     builder: (context) {
    //       return LoginDialog();
    //     });

    return showModalBottomSheet<bool>(
        context: context,
        builder: (context) {
          return LoginDialog();
        });
  }

  void getHttp() async {
    try {
      var response = await Dio().get('https://funge.fun/config');
      var data = response.data.toString().replaceRange(1, 2, "");

      List<int> bytes2 = base64Decode(data);
      String decodeStr = String.fromCharCodes(bytes2);
      var config =
          ConfigModel.fromJson(json.decode(decodeStr) as Map<String, dynamic>);

      if (config.l == 0) {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return HomePage();
        // }));
      } else {
        setState(() {
          _active = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
