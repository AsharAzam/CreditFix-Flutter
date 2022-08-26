// ignore_for_file: file_names, prefer_const_constructors

import 'package:core/UI/ChangePasswordPage.dart';
import 'package:core/Services/user_service.dart';
import 'package:core/Utils/Prefs.dart';
import 'package:core/UI/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/UI/signup.dart';

import 'package:core/Models/User.dart';
import 'package:core/Utils/utils.dart';
import 'package:core/Views/views.dart';

class Account extends StatefulWidget {
  static const String route = "Account";

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  BuildContext? _context;

  User? user;

  @override
  void initState() {
    super.initState();
    Prefs.getUser((u) {
      if (mounted)
        setState(() {
          this.user = u;
          // for testing
          this.user = User(
              id: 0,
              device_token: "lkasdjflkdf",
              name: "Alex",
              slug: "King",
              email: "Alex@retrocube.com",
              password: "123456",
              mobile_no: "1234567890",
              api_token: "N/A");
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('State: Account');
    _context = context;
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(child: body()),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text("Account"),
      actions: [
        PopupMenuButton(
            onSelected: (val) {
              if (val == "reset") {
                Navigator.popAndPushNamed(context, ChangePasswordPage.route);
              } else {
                toast("Logged Out");
                Prefs.removeUser();
                Navigator.pushNamedAndRemoveUntil(
                    context, Login.route, (route) => false);
              }
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: 'reset',
                  ),
                  PopupMenuItem(
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: 'logout',
                  )
                ]),
      ],
    );
  }

  Widget body() {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: user != null
            ? MyForm(
                user: user!,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget listItem(int position) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Icon(
          Icons.report,
          size: 40,
          color: Colors.red,
        ),
        title: Text(
          "Subject",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(
          "Pending",
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 10, color: Colors.black),
        ),
        trailing: Text(
          "15/Jul/2021",
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 10, color: Colors.black),
        ),
        onTap: () {
          // Navigator.pushNamed(context, FirDetails.route);
        },
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  User? user;

  MyForm({this.user});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_homeScreenkey');
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    String? fName, lName, phone, email, cnic;
    FocusNode fNameFocus = FocusNode(),
        lNameFocus = FocusNode(),
        phoneFocus = FocusNode(),
        emailFocus = FocusNode(),
        cnicFocus = FocusNode();

    return Form(
      key: _formKey,
      // autovalidate: autoValidate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LabeledEditText(
            context: context,
            hintText: 'First Name',
            labelText: 'First Name',
            value: widget.user?.name,
            validator: validateName,
            textInputAction: TextInputAction.next,
            currentFocus: fNameFocus,
            nextFocus: lNameFocus,
            onSaved: (text) {
              fName = text;
            },
            onChange: (text) {
              fName = text;
            },
          ),
          SizedBox(
            height: 10,
          ),
          LabeledEditText(
            context: context,
            hintText: 'Last Name',
            labelText: 'Last Name',
            value: widget.user?.slug,
            validator: validateName,
            textInputAction: TextInputAction.next,
            currentFocus: lNameFocus,
            nextFocus: cnicFocus,
            onSaved: (text) {
              lName = text;
            },
            onChange: (text) {
              lName = text;
            },
          ),
          SizedBox(
            height: 10,
          ),
          LabeledEditText(
            context: context,
            hintText: 'CNIC',
            labelText: 'CNIC',
            value: widget.user?.device_token,
            validator: validateField,
            textInputAction: TextInputAction.next,
            currentFocus: cnicFocus,
            nextFocus: phoneFocus,
            onChange: (text) {
              cnic = text;
            },
            onSaved: (val) {
              cnic = val;
            },
          ),
          SizedBox(
            height: 10,
          ),
          LabeledEditText(
            context: context,
            validator: validateMobile,
            autoValidate: true,
            prefixText: '+92',
            value: widget.user?.mobile_no,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.phone,
            inputFormatter: [
              // WhitelistingTextInputFormatter(new RegExp('[+1234567890]'))
            ],
            labelText: 'Phone#',
            hintText: '3001234567',
            currentFocus: phoneFocus,
            nextFocus: emailFocus,
            onSaved: (text) {
              phone = text;
            },
            onChange: (String? val) {
              phone = val;
            },
          ),
          SizedBox(
            height: 10,
          ),
          LabeledEditText(
            context: context,
            hintText: 'Email Address',
            labelText: 'Email Address',
            value: widget.user?.email,
            validator: validateEmail,
            setEnable: false,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            currentFocus: emailFocus,
            // nextFocus: passFocus,
            onSaved: (text) {
              email = text;
            },
            onChange: (text) {
              email = text;
            },
          ),
          SizedBox(
            height: 30,
          ),
          MyButton(
            text: "Update",
            onPress: () {
              if (_validateInputs()) {
                //check further
                //check further
                if (fName == null ||
                    lName == null ||
                    cnic == null ||
                    email == null ||
                    phone == null)
                  toast('All fields are required');
                else {
                  //Validated
                  // showLoading();
                  // updateUser(
                  //     fName: fName,
                  //     lName: lName,
                  //     mobile_no: phone,
                  //     cnic: cnic,
                  //     onSuccess: (User user) {
                  //       hideLoading();
                  //       toast("User updated");
                  //       Navigator.pop(context);
                  //     },
                  //     onError: (String error) {
                  //       hideLoading();
                  //       toast(error);
                  //     });
                  toast("User updated");
                  Navigator.pop(context);
                }
              } else {
                // toast('Invalidated');
              }
            },
          ),
        ],
      ),
    );
  }

  bool _validateInputs() {
    if (_formKey.currentState!.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState!.save();
      return true;
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        autoValidate = true;
      });
      return false;
    }
  }
}
