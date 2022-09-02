import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../datas/configModel.dart';
import '../main.dart';
import '../maxUitls/max_ad_id.dart';

class OutDailog extends Dialog {
  bool isNative = false;

  OutDailog(this.isNative, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: SizedBox(
          width: double.maxFinite,
          height: getSize().toDouble(),
          child: Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: Column(children: [
                TopWidget(),
                getMaxUi(),

                BottomButton(),
              ])),
        ),
      ),
    );
  }

  num getSize() {
    if (isNative) {
      return 400.0;
    } else {
      return 200.0;
    }
  }

  Widget getMaxUi() {
    if (isNative) {
      return MaxAdView(
        adUnitId: configModel.maxNative ?? "",
        adFormat: AdFormat.mrec,
      );
    } else {
      return Expanded(child: Container(),flex: 1,);
    }
  }

}


class TopWidget extends StatefulWidget {
  const TopWidget({Key? key}) : super(key: key);

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        Container(
          width: 10,
          height: 10,
        ),
        Center(
            child: Text(
              "Exit Message",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )),
        Container(
          height: 10,
        ),
        Center(
            child: Text(
              "Whether to quit the application",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ))
      ]),
    );
  }
}

class BottomButton extends StatefulWidget {
  const BottomButton({Key? key}) : super(key: key);

  @override
  State<BottomButton> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 6, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              child: Text("OK"),
              onPressed: () async {
                await pop();
              },
            ),
            flex: 3,
          ),
            Expanded(child: Container(), flex: 1,),
          Expanded(
            child: ElevatedButton(
              child: Text("CANCEL"),
              onPressed: () {},
            ),
            flex: 3,
          )
        ],
      ),
    );
  }
}

  Future<void> pop() async {
await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}