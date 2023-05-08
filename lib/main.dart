import 'package:final_project_flutter/pages/home.dart';
import 'package:flutter/material.dart';

// shift + alt + f 
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Social Network",
      theme: ThemeData(
        primaryColor: Colors.blue[400],
        accentColor: Colors.greenAccent[400],
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
