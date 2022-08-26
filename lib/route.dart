import 'dart:io';

import 'package:core/UI/ChangePasswordPage.dart';
import 'package:core/UI/EditProfile.dart';
import 'package:core/UI/MyProfile.dart';
import 'package:core/UI/login.dart';
import 'package:core/UI/signup.dart';
import 'package:core/UI/splash.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:core/UI/ForgetPasswordPage.dart';
import 'package:core/UI/InfoScreen.dart';
import 'package:core/UI/NotificationsScreen.dart';
import 'package:core/UI/VideoViewScreen.dart';
import 'package:core/UI/PhotoViewerPage.dart';
import 'package:core/UI/Home.dart';

Route<dynamic>? getRoute(RouteSettings settings) {
  late Map<String, Object> map;
  if (settings.arguments != null) {
    map = settings.arguments as Map<String, Object>;
  }
  switch (settings.name) {
    case '/':
      return setTransition(Splash());
    case SignUp.route:
      return setTransition(SignUp());
    case Login.route:
      return setTransition(Login());
    case Home.route:
      return setTransition(Home());
    // case Account.route:
    //   return setTransition(Account());
    case ChangePasswordPage.route:
      return setTransition(ChangePasswordPage());
    case ForgotPasswordPage.route:
      return setTransition(ForgotPasswordPage());
    case MyProfile.route:
      return setTransition(MyProfile());
    case EditProfile.route:
      return setTransition(EditProfile());
    case NotificationsScreen.route:
      return setTransition(NotificationsScreen());
    case VideoViewScreen.route:
      return setTransition(VideoViewScreen());
    case InfoScreen.route:
      return setTransition(InfoScreen(
          title: map['title'] as String, content: map['content'] as String));
    case PhotoViewerPage.route:
      return setTransition(PhotoViewerPage(
        url: map["url"] as String,
        local: map["local"] as bool,
      ));
    default:
      return null;
  }
}

PageTransition setTransition(Widget widget) {
  var animation =
      Platform.isIOS ? PageTransitionType.rightToLeft : PageTransitionType.fade;
  return PageTransition(
      child: widget, type: animation, duration: Duration(milliseconds: 300));
}
