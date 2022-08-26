import 'package:core/Services/user_service.dart';
import 'package:core/UI/Home.dart';
import 'package:core/Utils/ScreenConfig.dart';
import 'package:core/UI/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:core/UI/ForgetPasswordPage.dart';
import 'package:core/Utils/utils.dart';
import 'package:core/Views/views.dart';

class Login extends StatefulWidget {
  static const String route = "Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late BuildContext _context;

  FocusNode emailFocus = FocusNode(), passFocus = FocusNode();

  String? email, pass;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_Login');

  bool autoValidate = false, obscure = true;

  @override
  Widget build(BuildContext context) {
    print('State: Login');
    _context = context;
    return Scaffold(
      body: Container(
          // decoration: BoxDecoration(
          //   image:
          //   DecorationImage(image: AssetImage('src/bg.png'), fit: BoxFit.fill),
          // ),
          height: ScreenConfig.screenHeight,
          child: SingleChildScrollView(child: body())),
    );
  }

  Widget body() {
    return Container(

      // color: Colors.red,
      padding: const EdgeInsets.only(right: 16, left: 16, top: 35, bottom: 25),
      child: Form(
        key: _formKey,
        autovalidateMode: autoValidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "src/loginLogo.png",
              scale: 1.8,
            ),
            SizedBox(
              height: 70,
            ),
            Text(
              'Hello There',
              style: Theme.of(_context).textTheme.headline1,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Login or sign up to continue.',
              style: Theme.of(_context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 40,
            ),
            EditText(
              context: context,
              hintText: 'Email Address',
              validator: validateEmail,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              currentFocus: emailFocus,
              nextFocus: passFocus,
              // prefixIcon: "src/email.png",
              prefixiconData: Icons.email_outlined,
              onSaved: (text) {
                email = text;
              },
              onChange: (text) {
                email = text;
              },
            ),
            SizedBox(
              height: 10,
            ),
            EditText(
              context: context,
              hintText: 'Password',
              obscure: obscure,
              validator: validatePassword,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              isPassword: true,
              prefixIcon: 'src/password.png',
              // prefixiconData: Icons.password,
              icon: obscure
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              suffixClick: () {
                setState(() {
                  obscure = !obscure;
                });
              },
//               currentFocus: passFocus,
              // nextFocus: highSchoolFocus,
              onChange: (text) {
                pass = text;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ForgotPasswordPage.route);
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xff1e263f),
                    fontSize: 14,
                    fontFamily: 'Gibson-SemiBold',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            MyButton(
              text: 'SIGN IN',
              onPress: () {
                if (_validateInputs()) {
                  // showLoading();
                  // login(email: email!, password: pass!, onSuccess: (user) {
                  //   hideLoading();
                  //   Navigator.pushNamedAndRemoveUntil(
                  //     context,
                  //     Home.route,
                  //         (route) => false,
                  //   );
                  // }, onError: (error) {
                  //   hideLoading();
                  //   toast(error);
                  // });
                } else {
                  toast("Testing Mode enabled");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Home.route,
                    (route) => false,
                  );
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Divider(
                    indent: 30,
                    thickness: 1.5,
                    // endIndent: 30,
                    height: 50,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.transparent,
                    // width: 50,
                    // height: 10,
                    child: Text(
                      "or",textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Gibson',
                          fontSize: 15),
                    ),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Divider(
                    // indent: 30,
                    thickness: 1.5,
                    endIndent: 30,
                    height: 50,
                  ),
                ),
              ],
              // alignment: Alignment.center,
            ),
            socialButton('Continue with Facebook', "src/facebook.png", () {}),
            SizedBox(
              height: 10,
            ),socialButton('Continue with Google', "src/google.png", () {}),
            SizedBox(
              height: 10,
            ),socialButton('Continue with Apple ID', "src/apple.png", () {}),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.pushNamed(_context, SignUp.route);
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(
                        color: Theme.of(_context).hintColor,
                        fontFamily: "Gibson",
                        fontSize: 14,
                      ),
                    ),
                    const TextSpan(
                      text: "SIGN UP",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Gibson-SemiBold",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
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

  Widget socialButton(String text, String icon, VoidCallback onPress) {
    return MyButton(
      height: 48,
        color: Colors.grey[200],
        onPress: onPress,
        child: Row(
          children: [
            Image.asset(
              icon,
              scale: 1.7,
            ),
            Spacer(
              flex: 2,
            ),
            Text(text,
                style: TextStyle(
                    color: Color(0xff2f394e),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Gibson",
                    fontSize: 14.0)),
            Spacer(
              flex: 3,
            )
          ],
        ));
  }
}
