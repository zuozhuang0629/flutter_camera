import 'package:flutter/material.dart';

class ImageClick extends StatefulWidget {
  ImageClick({Key? key}) : super(key: key);

  @override
  State<ImageClick> createState() => _ImageClickState();
}

class _ImageClickState extends State<ImageClick> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Tap'),
        ));
      },
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text('Flat Button'),
      ),
    );
  }
}
