import 'dart:ffi';

import 'package:final_project_flutter/pages/activity_feed.dart';
import 'package:final_project_flutter/pages/profile.dart';
import 'package:final_project_flutter/pages/search.dart';
import 'package:final_project_flutter/pages/timeline.dart';
import 'package:final_project_flutter/pages/upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController = new PageController();
  int pageIndex = 0;
  @override
  void initState() {
    // حتتنفذ اول شي قبل البيلد
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        isAuth = true;
      });
    }, onError: (error) {
      print("error is $error");
    });

    try {
      //  عشان اذا المستخدم عامل لوجن يوديه للواجهة الرئيسية وا يرجعه عالبداية تسجيل الدخول
      googleSignIn.signInSilently(suppressErrors: false).then((account) {
        setState(() {
          isAuth = true;
        });
      }).catchError((err) {
        print("error in reopen $err");
      });
    } catch (e) {
      print("signInSilently error $e");
    }
  }

  @override
  void dispose() {
    // so dont use alot of catch
    super.dispose();
    pageController.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
      // اذا تغير شي في البيج فيو روح عليه عالانديكس اللي حيتغير مثلا 3 حيصير حيروح ع 3
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  Widget BuildAuthScreen() {
    // في حال تحقق تسجيل الدخول
    return Scaffold(
      body: PageView(
          children: <Widget>[
            const TimeLine(),
            const ActivityFeed(),
            const Upload(),
            const Search(),
            const Profile(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          // for navigate between pages
          physics: NeverScrollableScrollPhysics() // no scroll in page view ...,
          ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          activeColor: Theme.of(context).primaryColor,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none)),
            BottomNavigationBarItem(icon: Icon(Icons.camera_alt)),
            BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(icon: Icon(Icons.person)),
          ]),
    );
  }

  Widget BuildUnAuthScreen() {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 60.0, left: 20.0, bottom: 30.0),
            alignment: Alignment.bottomLeft,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Login"),
                  Text("Welcome to Social Chat")
                ]),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                )),
            child: SingleChildScrollView(
                // عشان اذا كانت صغيرة او كبيرة ما يطلعلي مشاكل في التصميم
                child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Text(
                      "Sign in google",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                )
              ],
            )),
          ))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? BuildAuthScreen() : BuildUnAuthScreen();
  }
}
