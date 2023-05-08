import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/header.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: header(context, titleText: "TimeLineState" ),
      body: Center(
        child: Text("Profile"),
      ),
    ));
  }
}
