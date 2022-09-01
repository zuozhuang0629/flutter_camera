import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';

class OutDailog extends StatefulWidget {
  const OutDailog({Key key}) : super(key: key);

  @override
  _OutDailogState createState() => _OutDailogState();
}

class _OutDailogState extends State<OutDailog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopWidget(),
        // MaxAdView(),

    );
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
      child: Center(
        child: Text(
          "Exit Message",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
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
        children: [],
      ),
    );
  }
}
