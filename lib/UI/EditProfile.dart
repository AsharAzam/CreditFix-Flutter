import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:core/Services/user_service.dart';
import 'package:core/Utils/ScreenConfig.dart';
import 'package:core/UI/Home.dart';
import 'package:core/Models/User.dart';
import 'package:core/Utils/utils.dart';
import 'package:core/Views/views.dart';

class EditProfile extends StatefulWidget {
  static const String route = 'EditProfile';

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   image:
      //       DecorationImage(image: AssetImage('src/bg.png'), fit: BoxFit.fill),
      // ),
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20), child: body()),
      ),
    );
  }

  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_editProfileScreenkey');
  bool autoValidate = false, obscure = true;
  File? image;

  String? userName, phone, email, dob, gender;
  FocusNode userNameFocus = FocusNode(),
      phoneFocus = FocusNode(),
      emailFocus = FocusNode(),
      dobFocus = FocusNode();

  appBar() => AppBar(title: Text("Edit Profile"), centerTitle: false, actions: [
        TextButton(
            onPressed: () {
              if (_validateInputs()) {
                //check further
                if (userName == null ||
                    dob == null ||
                    email == null ||
                    phone == null ||
                    gender == null)
                  toast('All fields are required');
                else {
                  // Validated
                  String gen = gender!.toLowerCase() == "male" ? "He" : "She";
                  showLoading();
                  updateUser(
                      name: userName!,
                      mobile_no: phone!,
                      email: email!,
                      dob: dob!,
                      gender: gen,
                      imagePath: image?.path,
                      onSuccess: (User user) {
                        hideLoading();
                        // Navigator.pushReplacementNamed(context, Home.route);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Home.route,
                              (route) => false,
                        );
                      },
                      onError: (String error) {
                        hideLoading();
                        toast(error);
                      });
                }
              } else {
                // toast('Invalidated');
              }
            },
            child: Text("Save",
                style: TextStyle(
                  fontFamily: 'Gibson',
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                )))
      ]);

  Widget body() {
    return Form(
      key: _formKey,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      // autovalidate: autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
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
            currentFocus: userNameFocus,
            nextFocus: emailFocus,
            prefixIcon: 'src/username.png',
            onSaved: (text) {
              userName = text;
            },
            onChange: (text) {
              userName = text;
            },
          ),
          const SizedBox(
            height: 15,
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
            height: 15,
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
            height: 15,
          ),
          datePicker(
            // onTap: () {},
            onChange: (val) {
              dob = val;
              print(dob);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Spinner(
            icon: 'src/gender.png',
            hint: 'Gender',
            array: const <String>['Male', 'Female'],
            onChange: (newValue) {
              gender = newValue;
            },
          ),
          const SizedBox(
            height: 10,
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
          val = DateFormat("yyyy-MM-dd").format(picked); // => 2019-04-21
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
  var array, hint, icon;
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
            Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 4),
              child: Image.asset(
                widget.icon,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 0, left: 4),
                  child: Image.asset(
                    widget.icon,
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
