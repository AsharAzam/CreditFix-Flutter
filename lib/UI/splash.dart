// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:core/Models/Station.dart';
import 'package:core/Services/user_service.dart';
import 'package:core/Utils/Prefs.dart';
import 'package:core/Views/views.dart';
import 'package:core/UI/Home.dart';
import 'package:core/UI/login.dart';
import 'package:core/UI/signup.dart';
import 'package:flutter/material.dart';

import 'package:core/Models/User.dart';
import 'package:core/Utils/ScreenConfig.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // String authToken = userProvider.getUser().token != null
    //     ? userProvider.getUser().token
    //     : null;
    // print("Auth Token: $authToken");
    // Prefs.removeUser();
    Future.delayed(Duration(seconds: 3), () {
      navigate(context);
    });
    // getStations(onSuccess: (List<Station> stations){
    //   navigate(context);
    // }, onError: (String error){
    //   toast(error);
    // });
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      // backgroundColor: Color.lerp(Colors.blue, Colors.white, 1),

      body: Image.asset(
        "src/splash.png",
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fill,
      ),
    );
  }

  void navigate(context) {
    Prefs.getUser((User? user){
      Navigator.pushReplacementNamed(context, user==null?Login.route:Home.route,
          arguments: {"type": "initial"});
    });
  }
}
