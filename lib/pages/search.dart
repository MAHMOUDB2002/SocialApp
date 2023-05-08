import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/header.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: header(context, titleText: "Search"),
      body: Center(
        child: Text("Search"),
      ),
    ));
  }
}
