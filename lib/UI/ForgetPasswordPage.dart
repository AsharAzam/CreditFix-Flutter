import 'package:core/Services/user_service.dart';
import 'package:core/Models/BaseModel.dart';
import 'package:core/UI/Home.dart';
import 'package:core/UI/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:core/Utils/utils.dart';
import 'package:core/Views/views.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String route = "ForgotPasswordPage";

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late BuildContext _context;

  late FocusNode emailFocus, passFocus;

  String? email, pass;

  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_ForgotPasswordPage');

  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    print('State: ForgotPasswordPage');
    _context = context;
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password?'),
        centerTitle: false,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      // decoration: BoxDecoration(
      //   image:
      //   DecorationImage(image: AssetImage('src/bg.png'), fit: BoxFit.fill),
      // ),
      // color: Colors.red,
      padding: EdgeInsets.only(right: 16, left: 16, top: 0, bottom: 60),
      child: Form(
        key: _formKey,
        autovalidateMode: autoValidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   'Forgot Password?',
            //   style: Theme.of(_context).textTheme.headline1,
            // ),
            SizedBox(
              height: 30,
            ),
            Image.asset(
              'src/forgot.png',
              scale: 1.8,
            ),
            SizedBox(
              height: 0,
            ),
            Text(
              'Enter the email associated with your account',
              style: Theme.of(_context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 20,
            ),
            EditText(
              context: _context,
              hintText: 'Email',
              // suffixIcon: 'src/username.png',
              validator: validateEmail,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              // currentFocus: emailFocus,
              // nextFocus: passFocus,
              onSaved: (text) {
                email = text;
              },
              onChange: (text) {
                email = text;
              },
            ),
            SizedBox(
              height: 15,
            ),
            MyButton(
              text: 'SUBMIT',
              onPress: () {
                if (_validateInputs()) {
                  showLoading();
                  forgetPassword(
                      email: email!,
                      onSuccess: (BaseModel baseModel) {
                        hideLoading();
                        toast(baseModel.message);
                        Navigator.pushReplacementNamed(_context, Home.route);
                      },
                      onError: (error) {
                        hideLoading();
                        toast(error);
                      });
                } else {
                  // toast("Testing Mode enabled");
                  // Navigator.pushReplacementNamed(_context, Home.route);
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
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
