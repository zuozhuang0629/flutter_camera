import 'package:flutter/material.dart';

class SelectDialog extends StatefulWidget {
  const SelectDialog({Key? key}) : super(key: key);

  @override
  State<SelectDialog> createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Filter",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
            textAlign: TextAlign.center),
        Text("Sticker",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
            textAlign: TextAlign.center),
        Text("Cartoon",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
            textAlign: TextAlign.center),
        Text("Cancel",
            style: TextStyle(color: Colors.red, fontSize: 18.0),
            textAlign: TextAlign.center)
      ],
    );
  }
}
