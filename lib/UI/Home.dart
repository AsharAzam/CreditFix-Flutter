import 'dart:math';

import 'package:flutter/material.dart';
import 'package:core/Views/views.dart';
import 'package:core/UI/NotificationsScreen.dart';
import 'package:core/UI/MyProfile.dart';

class Home extends StatefulWidget {
  static const String route = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BuildContext _context;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget>? _widgetOptions = <Widget>[
    Tab("One"),
    Tab("TwoTab"),
    Tab("ThreeTab"),
    Tab("FourTab"),
    Tab("FifthTab"),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('State: Home');
    _context = context;
    // _widgetOptions = <Widget>[
    //   Tab("One"),
    //   Tab("TwoTab"),
    //   Tab("ThreeTab"),
    //   Tab("FourTab"),
    //   Tab("FifthTab"),
    // ];
    return Scaffold(
      body: _widgetOptions?.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: barIcon('src/homeOff.png'),
            activeIcon: barIcon('src/homeOn.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: barIcon('src/ebookOff.png'),
            activeIcon: barIcon('src/ebookOn.png'),
            label: 'E-Book',
          ),
          BottomNavigationBarItem(
            icon: barIcon('src/musicOff.png'),
            activeIcon: barIcon('src/musicOn.png'),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: barIcon('src/videoOff.png'),
            activeIcon: barIcon('src/videoOn.png'),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: barIcon('src/moreOff.png'),
            activeIcon: barIcon('src/moreOn.png'),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'Gibson'),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'Gibson'),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[400],
        onTap: _onItemTapped,
        elevation: 0,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(),
      ),
    );
  }

  Widget barIcon(String icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        icon,
        height: 24,
        width: 24,
      ),
    );
  }
}

///This is sample tab, Tab widgets should be in different files
class Tab extends StatelessWidget {
  late BuildContext _context;
  String name = "";
  Tab(this.name);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: appBar(context),
      body: Center(child: Text(name),),
    );
  }

  PreferredSizeWidget appBar(context) {
    return AppBar(
      centerTitle: false,
      // leadingWidth: 40,
      titleSpacing: 10,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: InkWell(
          onTap: (){
           Navigator.pushNamed(context, MyProfile.route);
          },
          child: Image.asset(
            'src/avatar1.png',
            width: 40,
            height: 40,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Hi ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        fontFamily: 'Gibson')),
                TextSpan(
                  text: "Margaret",
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(_context).appBarTheme.titleTextStyle!.color,
                      fontFamily: 'Gibson-SemiBold'),
                ),
              ])),
          SizedBox(
            height: 5,
          ),
          Text("How are yor feeling today?",
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(_context).hintColor,
                  fontFamily: 'Gibson')),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(_context, NotificationsScreen.route);
            },
            icon: Image.asset(
              'src/notification.png',
              scale: 2,
            )),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
