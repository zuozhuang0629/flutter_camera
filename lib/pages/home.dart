import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/pages/camera_page.dart';
import 'package:flutter_camera/pages/cartoon_page.dart';
import 'package:flutter_camera/pages/filter_page.dart';
import 'package:flutter_camera/pages/sticker_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../main.dart';
import '../maxUitls/max_ad_id.dart';
import '../utils/mlog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        return true;
      },
      child:  Scaffold(
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(alignment: Alignment.center, children: <Widget>[
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image.asset(
                "assets/images/bg_xuxing.png",
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: <Widget>[
                Image.asset(
                  "assets/images/ic_home_bg.png",
                  fit: BoxFit.fill,
                ),
                BottomWidget1(),
                BottomWidget2(),
                Expanded(
                  child: Padding(padding:EdgeInsets.fromLTRB(0, 10, 0, 10),child:
                  MaxAdView(
                      adUnitId: ad_unit_id,
                      adFormat: AdFormat.mrec,

                      listener: AdViewAdListener(onAdLoadedCallback: (ad) {
                        logStatus('MREC widget ad loaded from ' + ad.networkName);
                      }, onAdLoadFailedCallback: (adUnitId, error) {
                        logStatus(
                            'MREC widget ad failed to load with error code ' +
                                error.code.toString() +
                                ' and message: ' +
                                error.message);
                      }, onAdClickedCallback: (ad) {
                        logStatus('MREC widget ad clicked');
                      }, onAdExpandedCallback: (ad) {
                        logStatus('MREC widget ad expanded');
                      }, onAdCollapsedCallback: (ad) {
                        logStatus('MREC widget ad collapsed');
                      })),

                  )  , flex: 1,),
                SizedBox(
                  height: 70,
                  child: Container(),
                )

              ],
            ),
          ]),
        ),
      )
    );




  }
}

//第一排按钮
class BottomWidget1 extends StatefulWidget {
  BottomWidget1({Key? key}) : super(key: key);

  @override
  State<BottomWidget1> createState() => _BottomWidget1State();
}

String? selPath = null;

class _BottomWidget1State extends State<BottomWidget1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: InkWell(
                child: Image.asset(
                  "assets/images/ic_home_mera.png",
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CameraApp((path) async {
                              selPath = path;
                              Navigator.pop(context);
                              var index = await changeModel();

                              if (index == 1) {
                                Navigator.push(this.context,
                                    MaterialPageRoute(builder: (context) {
                                  return FilterPage();
                                }));
                              } else if (index == 2) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return StickerPage();
                                }));
                              } else if (index == 3) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CartoonPage();
                                }));
                              }
                            })),
                  );
                },
              )),
          SizedBox(width: 10,child: Container(),),
          Expanded(
              flex: 1,
              child: InkWell(
                child: Image.asset(
                  "assets/images/ic_home_ter.png",
                  fit: BoxFit.fill,
                ),
                onTap: () {},
              )),
        ]));
  }

  Future<int?> changeModel() async {
    return await showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Please select'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('Filter'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('Sticker'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 3);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('Cartoon'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 4);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('Cancel'),
                ),
              ),
            ],
          );
        });
  }
}

//第二排按钮
class BottomWidget2 extends StatefulWidget {
  BottomWidget2({Key? key}) : super(key: key);

  @override
  State<BottomWidget2> createState() => _BottomWidget2State();
}

class _BottomWidget2State extends State<BottomWidget2> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 0),child: Row(children: <Widget>[
      Expanded(
          flex: 1,
          child: InkWell(
            child: Image.asset(
              "assets/images/ic_home_ker.png",
              fit: BoxFit.fill,
            ),
            onTap: () {},
          )),
      SizedBox(width: 10,child: Container(),),
      Expanded(
          flex: 1,
          child: InkWell(
            child: Image.asset(
              "assets/images/ic_home_toon.png",
              fit: BoxFit.fill,
            ),
            onTap: () {},
          )),
      SizedBox(width: 10,child: Container(),),
      Expanded(
          flex: 1,
          child: InkWell(
              child: Image.asset(
                "assets/images/ic_home_are.png",
                fit: BoxFit.fill,
              ),
              onTap: () async {
                final info = await PackageInfo.fromPlatform();

                var sAux = "\n Photo frame\n\n";
                sAux = """
                    ${sAux}https://play.google.com/store/apps/details?id=${info.packageName}""";

                await Share.share(sAux, subject: "text/plain");
              })),
    ]));
  }
}
