import 'package:flutter/material.dart';
import 'package:core/Services/user_service.dart';
import 'package:core/Utils/utils.dart';
import 'package:core/Views/views.dart';

import 'package:core/UI/EditProfile.dart';
import 'package:core/Models/User.dart';

class MyProfile extends StatefulWidget {
  static const route = 'MyProfile';

  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  User? user;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      showLoading();
      getProfile(onSuccess: (User user) {
        hideLoading();
        setState(() {
          this.user = user;
        });
      }, onError: (String error) {
        hideLoading();
        toast(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: body(),
        // padding: EdgeInsets.all(16.0),
      ),
    );
  }

  appBar() => AppBar(
        title: Text('Profile'),
        centerTitle: false,
        // elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProfile.route);
              },
              icon: Icon(
                Icons.edit,
                // scale: 1.7,
                color: Colors.black87,
              )),
          SizedBox(
            width: 10,
          )
        ],
      );

  Widget body() {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        CircleAvatar(
          foregroundImage: (user != null
              ? NetworkImage(user!.image_url!)
              : AssetImage('src/avatar1.png') as ImageProvider),
          backgroundImage: AssetImage('src/avatar1.png'),
          radius: 60,
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Stack(children: [
        //     Padding(
        //         padding: EdgeInsets.all(10),
        //         child: user != null
        //             ? Image.network(
        //                 user!.image_url!,
        //                 scale: 1.9,
        //                 width: 120,
        //                 height: 120,
        //           fit: BoxFit.cover,
        //               )
        //             : Image.asset(
        //                 'src/avatar1.png',
        //                 scale: 1.9,
        //                 width: 120,
        //                 height: 120,
        //               )),
        //     // Positioned(
        //     //     top: 55,
        //     //     right: 0,
        //     //     child: Image.asset(
        //     //       'src/add.png',
        //     //       scale: 2,
        //     //     ))
        //   ]),
        // ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            user != null ? user!.name! : 'Margaret Willson',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Gibson-SemiBold',
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Card(
// margin: EdgeInsets.all(16),

          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // color: Colors.grey[100],
          child: Column(
            children: [
              profilemenuItem("email", "Email Address",
                  user != null ? user!.email : "Margaretwillson@outlook.com"),
              SizedBox(
                height: 5,
              ),
              profilemenuItem("phone", "Phone Number",
                  user != null ? user!.mobile_no : "+35964463368"),
              SizedBox(
                height: 5,
              ),
              profilemenuItem("date", "Date of Birth",
                  user != null ? user!.date_of_birth : "02/21/1990"),
              SizedBox(
                height: 5,
              ),
              profilemenuItem(
                  "gender",
                  "Gender",
                  user != null
                      ? (user!.gender! == "He" ? "Male" : "Female")
                      : "Female"),
            ],
          ),
        )
      ],
    );
  }

  Widget profilemenuItem(asset, title, text, {bool next = false, onTap}) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Image.asset(
          'src/${asset}.png',
          scale: 2,
          color: Colors.black,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontFamily: 'Gibson', fontSize: 14.0),
        //textAlign: TextAlign.left
      ),
      subtitle: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontFamily: 'Gibson', fontSize: 14.0),
        //textAlign: TextAlign.left
      ),
      horizontalTitleGap: 0,
      trailing: next
          ? Image.asset(
              'src/more_next.png',
              scale: 2.5,
            )
          : null,
      onTap: onTap,
    );
  }
}
