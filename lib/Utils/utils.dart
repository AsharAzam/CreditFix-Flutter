import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

String? validateName(String? value) {
  if (value == null) {
    return null;
  } else if (value.length < 3) {
    return 'Name must be more than 2 charater';
  } else if (value.contains('  ')) {
    return 'Double space is not allowed between name';
  }
}

String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
  if (value == null) {
    return null;
  } else if (value.length != 10) return 'Mobile Number must be of 10 digit';
  if (value.length > 11) return 'Mobile number cannot be more than 11 digits';
  if (value.contains('-')) {
    return 'Only numbers are allowed';
  }
}

String? validatePassword(String? value) {
  if (value != null && value.length < 6) {
    return 'Password must be atleast 6 charaters';
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (value != null && !regex.hasMatch(value)) {
    return 'Enter Valid Email';
  } else {
    return null;
  }
}

String? validateField(String? value) {
  if (value != null && value.length == 0) {
    return 'Required';
  }
}

String? validateGraduationYear(String value) {
  if (value.length == 0) {
    return 'Required';
  } else if (value.contains('-')) {
    return 'Only numbers are allowed';
  } else if (value.length > 4) {
    return 'Example: 2005';
  } else {
    return null;
  }
}

Future<bool> isConnected() async {
  try {
//    final result = await InternetAddress.lookup('example.com');
//    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//      return true;
//    }else
//      return false;
    final result = await InternetAddress.lookup('example.com')
        .timeout(Duration(seconds: 3), onTimeout: () {
      return [];
    });
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

void IsConnected(Function(bool) connected) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connected(true);
    } else {
      connected(false);
    }
  } on SocketException catch (_) {
    connected(false);
  }
}

Timer? _timer;

Future<void> showLoading() {
  _timer = Timer(const Duration(seconds: 25), () {
    if (EasyLoading.isShow) {
      hideLoading();
      EasyLoading.showToast("Something went Wrong!, Try Again");
    }
  });

  return EasyLoading.show(
    status: "Loading..",
    maskType: EasyLoadingMaskType.black,
  );
}

Future<void> hideLoading() {
  _timer?.cancel();
  return EasyLoading.dismiss();
}

String formatDate(
    {required int dateInMilliSeconds, String dateFormat = "dd/MMM/yyyy"}) {
  // DateTime dateTime = DateFormat("yyyy-MM-dd").parse(dateString);
  if (dateInMilliSeconds == null) {
    return dateFormat;
  } else {
    return DateFormat(dateFormat)
        .format(DateTime.fromMillisecondsSinceEpoch(dateInMilliSeconds));
  }
}

//Date: 'EEEE, dd MMMM yyyy'  Time: 'hh:mm a'"
String formatTime(String timeString, String timeFormat) {
  DateTime dateTime = DateFormat("H:m").parse(timeString);
  return DateFormat(timeFormat).format(dateTime);
}

String formatDateAndTime(
    {required String dateString, String dateFormat = "MM-dd-yyyy hh:mm a"}) {
  DateTime dateTime = DateFormat("yyyy-MM-dd H:m:s").parse(dateString);
  return DateFormat(dateFormat).format(dateTime);
}

String durationToString(Duration d) {
  /// Returns a formatted string for the given Duration [d] to be DD:HH:mm:ss
  /// and ignore if 0.
  var seconds = d.inSeconds;
  final days = seconds ~/ Duration.secondsPerDay;
  seconds -= days * Duration.secondsPerDay;
  final hours = seconds ~/ Duration.secondsPerHour;
  seconds -= hours * Duration.secondsPerHour;
  final minutes = seconds ~/ Duration.secondsPerMinute;
  seconds -= minutes * Duration.secondsPerMinute;

  final List<String> tokens = [];
  if (days != 0) {
    tokens.add('${days}d');
  }
  if (tokens.isNotEmpty || hours != 0) {
    tokens.add('${hours}h');
  }
  if (tokens.isNotEmpty || minutes != 0) {
    tokens.add('${minutes}m');
  }
  tokens.add('${seconds}s');

  return tokens.join(':');
}

/// Show option to select image from Gallery or Camera
void showImageSelectOption(context, Function completionHandler) {
  if (Platform.isIOS) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              Navigator.pop(context);
              addImageFromSource(
                ImageSource.camera,
                    (image) {
                  completionHandler(image);
                },
              );
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Gallery'),
            onPressed: () {
              addImageFromSource(
                ImageSource.gallery,
                    (image) {
                  completionHandler(image);
                },
              );
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  } else {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(children: [
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Camera'),
          onTap: () {
            addImageFromSource(
              ImageSource.camera,
                  (image) {
                completionHandler(image);
              },
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Gallery'),
          onTap: () {
            addImageFromSource(
              ImageSource.gallery,
                  (image) {
                completionHandler(image);
              },
            );
          },
        ),
      ]),
    );
  }
}

/// Add image from selected source
void addImageFromSource(ImageSource source, Function completionHandler) {
  ImagePicker().pickImage(source: source).then(
        (image) {
      if (image == null) return null;
      return completionHandler(File(image.path));
    },
  ).catchError(
        (error) {
      print('Failed to pick image: $error');
    },
  );
}
