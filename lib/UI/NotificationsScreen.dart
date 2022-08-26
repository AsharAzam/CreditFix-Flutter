import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:core/UI/Account.dart';
import 'package:flutter/material.dart';
import 'package:core/Utils/ScreenConfig.dart';
import 'package:core/Views/views.dart';

import 'package:core/Utils/Const.dart';
import 'package:core/Utils/Font.dart';

class NotificationsScreen extends StatefulWidget {
  static const String route = "NotificationsScreen";

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    print('State: NotificationsScreen');
    _context = context;
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: body(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      title: Text("Notifications"),
      centerTitle: false,
      titleSpacing: 0,
      // backgroundColor: Color(0x1a59a8a6),
      elevation: 0,
    );
  }

  Widget body() {
    var items = [1,2,3,4,5,6,7];
    return ListView.separated(
        // padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 || index == 3)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(index == 0 ? " Today" : " Yesterday",
                      style: const TextStyle(
                          color: const Color(0xff78849e),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Gibson",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                          height: 1),
                      textAlign: TextAlign.left),
                ),
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Text(
                            "Quisque suscipit ipsum est, eu venenatis leo ornare eget. Ut porta facilisis elementum. ",
                            style: const TextStyle(
                                color: Color(0xff78849e),
                                fontFamily: Font.Regular,
                                fontSize: 12.0),
                            textAlign: TextAlign.left),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: Colors.orange.shade200,
                      ),
                      Text("  1m",
                          style: const TextStyle(
                              color: Color(0xff78849e),
                              fontFamily: Font.Regular,
                              fontSize: 12.0),
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: items.length);
  }
}
