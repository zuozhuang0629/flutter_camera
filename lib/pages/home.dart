import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              BottomWidget2()
            ],
          ),
        ]),
      ),
    );
  }
}

class BottomWidget1 extends StatefulWidget {
  BottomWidget1({Key? key}) : super(key: key);

  @override
  State<BottomWidget1> createState() => _BottomWidget1State();
}

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
                onTap: () {},
              )),
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
}

class BottomWidget2 extends StatefulWidget {
  BottomWidget2({Key? key}) : super(key: key);

  @override
  State<BottomWidget2> createState() => _BottomWidget2State();
}

class _BottomWidget2State extends State<BottomWidget2> {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 1,
          child: InkWell(
            child: Image.asset(
              "assets/images/ic_home_ker.png",
              fit: BoxFit.fill,
            ),
            onTap: () {},
          )),
      Expanded(
          flex: 1,
          child: InkWell(
            child: Image.asset(
              "assets/images/ic_home_toon.png",
              fit: BoxFit.fill,
            ),
            onTap: () {},
          )),
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

                await Share.share(sAux,subject:"text/plain");


              })),
    ]);
  }


}
