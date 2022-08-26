import 'package:core/Utils/utils.dart';
import 'package:core/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';

import 'Views/views.dart';

void main() => runApp(MyApp());

var navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('State: MyApp');
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    Color? hintColor = Color(0xff78849e);
    return OKToast(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: MaterialApp(
          title: 'Core App',
          // navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: getRoute,
          theme: ThemeData(
              fontFamily: 'Gibson-SemiBold',
              primaryColor: const Color(0xff59a8a6),
              hintColor: hintColor,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleSpacing: 0,
                  titleTextStyle: TextStyle(
                      fontFamily: 'Gibson-SemiBold',
                      fontSize: 18,
                      // fontWeight: FontWeight.w600,
                      color: Colors.black)),
              textTheme: const TextTheme(
                headline1: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                subtitle1: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff78849e),
                    fontFamily: 'Gibson'),
//            button: TextStyle(color: Colors.white),
              ),
//            Commenting button theme because its also getting applied to flat buttons
//              buttonTheme: ButtonThemeData(
//                buttonColor: Colors.indigo[800],
//                height: 40,
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(30),
//                  side: BorderSide(color: Theme.of(context).primaryColor),
//                ),
//              ),
//          primaryColorDark: Colors.white,
//          accentColor: Colors.white,

              brightness: Brightness.light
//        primarySwatch: Colors.blue[800],
              ),
          builder: (BuildContext context, Widget? child) {
            return FlutterEasyLoading(child: child);
          },
          // home: SignUp(),
        ),
      ),
    );
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      toast('Press again to exit!');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
