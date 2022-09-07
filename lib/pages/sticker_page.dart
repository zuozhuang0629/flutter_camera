import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera/utils/mlog.dart';

import '../sticker/stickerview.dart';
import 'home.dart';

class StickerPage extends StatefulWidget {
  List<String> stickers = List.from([
    "assets/images/ic_stick_1.png",
    "assets/images/ic_stick_2.png",
    "assets/images/ic_stick_3.png",
    "assets/images/ic_stick_4.png"
  ]);

  StickerPage({Key? key}) : super(key: key);

  @override
  State<StickerPage> createState() => _StickerPageState();
}

class _StickerPageState extends State<StickerPage> {
  List<String> showSticker = List.from([]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.d("build come");
    return Scaffold(
        appBar: AppBar(title: const Text('Sticker')),
        body: Column(
          children: <Widget>[
            selPath == null
                ? Text("get image is null")
                : Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.maxFinite,
                          child: Image.file(File(selPath!),
                              alignment: Alignment.center, fit: BoxFit.cover),
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          logger.d("LayoutBuilder come");
                          return StickerView(
                            width: constraints.maxWidth,
                            height: constraints.biggest.height,
                            stickerList: getAllShowStick(),
                          );
                        })
                      ],
                    )),
            SizedBox(
              width: double.infinity,
              height: 170.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  itemCount:
                      widget.stickers == null ? 0 : widget.stickers!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                            width: 80.0,
                            height: 140.0,
                            child: InkWell(
                              child: Image.asset(
                                widget.stickers![index],
                                width: 80.0,
                                height: 110.0,
                              ),
                              onTap: () {
                                setState(() {
                                  showSticker.add(widget.stickers![index]);
                                  logger.d("${showSticker}");
                                });
                              },
                            )));
                  }),
            ),
            SizedBox(
              width: double.infinity,
              height: 70.0,
            )
          ],
        ));
  }

  List<Sticker> getAllShowStick() {
    logger.d("getAllShowStick come");
    var result = <Sticker>[];
    for (int index = 0; index < showSticker.length; index++) {
      logger.d("for come");
      result.add(Sticker(
        id: '${index}',
        child: Image.asset(showSticker[index]),
      ));

    }
    logger.d("${result}");

    return result;
  }
}
