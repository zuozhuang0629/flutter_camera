import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../maxUitls/max_ad_id.dart';
import 'home.dart';

class FilterPage extends StatefulWidget {
  List<String> filters = List.from([
    "assets/images/ic_style_1.png",
    "assets/images/ic_style_2.png",
    "assets/images/ic_style_3.png",
    "assets/images/ic_style_4.png"
  ]);

  FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter')),
      body: Column(
        children: <Widget>[
          selPath == null
              ? Text("get image is null")
              : Expanded(
              child: Image.file(File(selPath!),
                  alignment: Alignment.center, fit: BoxFit.cover)),
          SizedBox(
            width: double.infinity,
            height: 170.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemCount: widget.filters == null
                    ? 0
                    : widget.filters!.length,
                itemBuilder: (context, index) {
                  return FilterWidget(
                      widget.filters![index], "style_${index + 1}");
                }),
          ),
          SizedBox(
            width: double.infinity,
            height: 70.0,
            child: MaxAdView(adUnitId:banner_ad_unit_id, adFormat: AdFormat.banner,),
          )
        ],
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  String imgPath;
  String title;

  FilterWidget(this.imgPath, this.title, {Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child: Container(
      width: 80.0,
      height: 140.0,
      child: Column(
        children: [
          SizedBox(
            width: 80.0,
            height: 110.0,
            child: Image.asset(widget.imgPath),
          ),
          Text(widget.title, textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 18.0),)
        ],
      ),
    ));
  }
}
