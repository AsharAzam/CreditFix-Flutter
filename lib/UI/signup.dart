import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// import 'HowToUseApp.dart';
import 'package:core/Models/User.dart';
import 'package:core/Services/user_service.dart';
import 'package:core/Utils/utils.dart';
import 'package:core/Views/views.dart';
import 'package:core/UI/Home.dart';
import 'package:core/UI/login.dart';

class SignUp extends StatefulWidget {
  static const String route = "SignUp";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    print('State: SignUp');
    _context = context;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: body()),
    );
  }

  Widget body() {
    String phone;
    return Container(
      // decoration: BoxDecoration(
      //   image:
      //       DecorationImage(image: AssetImage('src/bg.png'), fit: BoxFit.fill),
      // ),
      // color: Colors.red,
      padding: const EdgeInsets.only(right: 16, left: 16, top: 20, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Text(
            'Register',
            style: Theme.of(_context).textTheme.headline1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Register yourself here to continue',
            style: Theme.of(_context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 20,
          ),
          MyForm(),
          const SizedBox(
            height: 20,
          ),
          FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pushReplacementNamed(_context, Login.route);
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      fontFamily: 'Gibson',
                      color: Theme.of(_context).hintColor,
                      fontSize: 14,
                    ),
                  ),
                  const TextSpan(
                    text: "SIGN IN",
                    style: TextStyle(
                      fontFamily: 'Gibson-SemiBold',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_homeScreenkey');
  bool autoValidate = false, obscure = true;
  File? image;

  @override
  Widget build(BuildContext context) {
    String? lName, gender, phone, email, pass, dob;
    FocusNode lNameFocus = FocusNode(),
        phoneFocus = FocusNode(),
        emailFocus = FocusNode(),
        passFocus = FocusNode(),
        dobFocus = FocusNode();

    return Form(
      key: _formKey,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      // autovalidate: autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          image!,
                          scale: 1.7,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'src/ProfilePlaceholder.png',
                        scale: 1.7,
                        width: 120,
                        height: 120,
                      ),
              ),
              Positioned(
                  top: 50,
                  left: 110,
                  child: GestureDetector(
                    child: Image.asset(
                      'src/add.png',
                      scale: 1.7,
                    ),
                    onTap: () {
                      showImageSelectOption(context, (image) {
                        if (image != null) {
                          setState(() {
                            this.image = image;
                          });
                        }
                      });
                    },
                  ))
            ]),
          ),
          const SizedBox(
            height: 30,
          ),
          EditText(
            context: context,
            hintText: 'Full Name',
            validator: validateName,
            textInputAction: TextInputAction.next,
            currentFocus: lNameFocus,
            nextFocus: emailFocus,
            prefixIcon: 'src/username.png',
            onSaved: (text) {
              lName = text;
            },
            onChange: (text) {
              lName = text;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          EditText(
            context: context,
            hintText: 'Email Address',
            prefixiconData: Icons.email_outlined,
            validator: validateEmail,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            currentFocus: emailFocus,
            nextFocus: phoneFocus,
            onChange: (text) {
              email = text;
            },
            onSaved: (val) {
              email = val;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          EditText(
            context: context,
            validator: validateMobile,
            // prefixText: '+92',
//            value: '+923001234567',
            prefixIcon: "src/phone.png",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.phone,
            inputFormatter: [
              // WhitelistingTextInputFormatter(new RegExp('[+1234567890]'))
            ],
            hintText: 'Phone Number',
            currentFocus: phoneFocus,
            nextFocus: dobFocus,
            onSaved: (text) {
              phone = text;
            },
            onChange: (String? val) {
              phone = val;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          datePicker(
            // onTap: () {},
            onChange: (val) {
              dob = val;
              print(dob);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Spinner(
            icon: 'src/gender.png',
            hint: 'Select Gender',
            array: const <String>['Male', 'Female'],
            onChange: (newValue) {
              gender = newValue;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          EditText(
            context: context,
            hintText: 'Password',
            obscure: obscure,
            validator: validatePassword,
            isPassword: true,
            prefixIcon: 'src/password.png',
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
//            obscure: true,
            currentFocus: passFocus,
            icon: obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            suffixClick: () {
              setState(() {
                obscure = !obscure;
              });
            },
            onChange: (text) {
              pass = text;
            },
            onSaved: (val) {
              pass = val;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          MyButton(
            text: "Sign Up",
            onPress: () {
              if (_validateInputs()) {
                //check further
                if (lName == null ||
                    dob == null ||
                    email == null ||
                    phone == null ||
                    pass == null ||
                gender == null)
                  toast('All fields are required');
                else {
                  // Validated
                  String gen = gender!.toLowerCase() == "male" ? "He" : "She";
                  // String birth = dob!.split("-").reversed.join("-");
                  showLoading();
                  signUp(
                      name: lName!,
                      email: email!,
                      mobile_no: phone!,
                      dob: dob!,
                      gender: gen,
                      password: pass!,
                      confirm_password: pass!,
                      imagePath: image?.path,
                      onSuccess: (User user) {
                        hideLoading();
                        Navigator.pushReplacementNamed(context, Home.route);
                      },
                      onError: (String error) {
                        hideLoading();
                        toast(error);
                      });
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, HowToUseApp.route, (route) => false,
                  //     arguments: {"isOnboarding": true});
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

class datePicker extends StatefulWidget {
  Function(String?)? onChange;
  Widget? child;
  String? initVal;

  datePicker({this.child, this.onChange, this.initVal});

  @override
  _datePickerState createState() => _datePickerState();
}

class _datePickerState extends State<datePicker> {
  String val = 'Date of Birth';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future _selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2005),
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark(),
            child: child!,
          );
        },
      );
      if (picked != null) {
        setState(() {
          val = DateFormat("yyyy-MM-dd").format(picked); // => 21-04-2019
          widget.onChange!(val);
          controller.text = val;
          // return val;
        });
      }
    }

    return Container(
      child: InkWell(
        onTap: _selectDate,
        // child: EditText(
        //   context: context,
        //   hintText: val,
        //   setEnable: false,
        // ),
        child: EditText(
            context: context,
            hintText: val,
            controller: controller,
            // validator: validateField,
            prefixIcon: 'src/date.png',
            setEnable: false,
            onSaved: (text) {},
            onChange: (text) {
              widget.onChange!(text);
            }),
      ),
    );
  }
}

class Spinner extends StatefulWidget {
  var array, hint;
  String? icon;
  Function onChange;

  Spinner({this.hint, this.array, this.icon, required this.onChange});

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
//    final Map<String, IconData> _data = Map.fromIterables(
//        ['First', 'Second', 'Third'],
//        [Icons.filter_1, Icons.filter_2, Icons.filter_3]);
//    String _selectedType;
//    IconData _selectedIcon;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xfff7f9ff),
        borderRadius: BorderRadius.circular(18),
      ),
      child: DropdownButton<String>(
        hint: Row(
          children: <Widget>[
            if (widget.icon != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 4),
                child: Image.asset(
                  widget.icon!,
                  scale: 2.5,
                ),
              ),
            SizedBox(
              width: 13,
            ),
            Text(
              widget.hint,
              style: const TextStyle(
                  color: Color(0xff78849e), fontSize: 16, fontFamily: 'Gibson'),
            ),
          ],
        ),
        isExpanded: true,
        value: dropdownValue,
        iconEnabledColor: Colors.black,
        icon: Image.asset(
          'src/down.png',
          scale: 2,
        ),
//        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 1,
          color: Colors.transparent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue;
            widget.onChange(newValue);
          });
        },
        items: widget.array.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: <Widget>[
                if (widget.icon != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, left: 4),
                    child: Image.asset(
                      widget.icon!,
                      scale: 2.5,
                    ),
                  ),
                const SizedBox(
                  width: 13,
                ),
                Text(
                  value,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
