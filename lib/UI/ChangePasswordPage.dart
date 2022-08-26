import 'package:flutter/material.dart';
import 'package:core/Utils/ScreenConfig.dart';

import 'package:core/Services/user_service.dart';
import 'package:core/Utils/utils.dart';
import 'package:core/Views/views.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String route = "/ChangePasswordPage";

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var oldPasswordNode = FocusNode();
  var newPasswordNode = FocusNode();
  var confPasswordNode = FocusNode();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var _form = GlobalKey<FormState>();
  bool oldObscure = true, newObscure = true, confObscure = true;

  savePassword() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    showLoading();
    // changePassword(
    //     oldPassword: oldPassController.text,
    //     newPassword: newPassController.text,
    //     onSuccess: (baseModel) {
    //       hideLoading();
    //       if (baseModel.code == 200) {
    //         Navigator.pop(context);
    //       }
    //       toast(baseModel.message);
    //     },
    //     onError: (error) {
    //       hideLoading();
    //       toast(error);
    //     });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Change Password"), centerTitle: false, actions: [
        TextButton(
            onPressed: () {
              savePassword();
            },
            child: Text("Save",
                style: TextStyle(
                  fontFamily: 'Gibson',
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                )))
      ]),
      body: SingleChildScrollView(
        // decoration: BoxDecoration(
        //   image:
        //   DecorationImage(image: AssetImage('src/bg.png'), fit: BoxFit.fill),
        // ),
        // color: Colors.red,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 00,
                ),
                Image.asset(
                  'src/ChangePassword.png',
                  scale: 1.8,
                ),
                EditText(
                  context: context,
                  hintText: 'Old Password',
                  currentFocus: oldPasswordNode,
                  nextFocus: newPasswordNode,
                  controller: oldPassController,
                  obscure: oldObscure,
                  isPassword: true,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  icon: oldObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  suffixClick: () {
                    setState(() {
                      oldObscure = oldObscure ? false : true;
                    });
                  },
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return 'Old password is empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                EditText(
                  context: context,
                  hintText: 'New Password',
                  currentFocus: newPasswordNode,
                  nextFocus: confPasswordNode,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscure: newObscure,
                  controller: newPassController,
                  isPassword: true,
                  icon: newObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  suffixClick: () {
                    setState(() {
                      newObscure = newObscure ? false : true;
                    });
                  },
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return 'New password  is empty';
                    }
                    if (value.toString().length < 6) {
                      return 'New password must be greater than 6 characters.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                EditText(
                  context: context,
                  onFieldSubmitted: (_) {
                    savePassword();
                  },
                  hintText: 'Confirm Password',
                  currentFocus: confPasswordNode,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscure: confObscure,
                  isPassword: true,
                  icon: confObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  suffixClick: () {
                    setState(() {
                      confObscure = confObscure ? false : true;
                    });
                  },
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return 'Confirm password  is empty';
                    }
                    if (newPassController.text != value.toString()) {
                      return 'Confirm password does not match.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    oldPasswordNode.dispose();
    newPasswordNode.dispose();
    confPasswordNode.dispose();
    oldPassController.dispose();
    newPassController.dispose();
    super.dispose();
  }
}
