import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/header.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: header(context,titleText: "Upload"),
      body: Center(
        child: Text("Upload"),
      ),
    )
    );
  }
}
