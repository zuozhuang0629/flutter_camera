import 'dart:io';

import 'package:flutter/material.dart';

import 'home.dart';

class CartoonPage extends StatefulWidget {
  List<String> coons = List.from([
    "assets/images/ic_conn_1.png",
    "assets/images/ic_conn_2.png",
    "assets/images/ic_conn_3.png",
    "assets/images/ic_conn_4.png"
  ]);

  CartoonPage({Key? key}) : super(key: key);

  @override
  State<CartoonPage> createState() => _CartoonPageState();
}

class _CartoonPageState extends State<CartoonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cartoon')),
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
                itemCount: widget.coons == null ? 0 : widget.coons!.length,
                itemBuilder: (context, index) {
                  return CoonWidget(
                      widget.coons![index], "style_${index + 1}");
                }),
          ),
          SizedBox(
            width: double.infinity,
            height: 70.0,
          )
        ],
      ),
    );
  }
}

class CoonWidget extends StatefulWidget {
  String imgPath;
  String title;

  CoonWidget(this.imgPath, this.title, {Key? key}) : super(key: key);

  @override
  State<CoonWidget> createState() => _CoonWidgetState();
}

class _CoonWidgetState extends State<CoonWidget> {
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