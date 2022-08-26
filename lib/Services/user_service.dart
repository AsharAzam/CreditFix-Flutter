import 'dart:io';

import 'package:core/Models/Fir.dart';
import 'package:core/Models/Station.dart';
import 'package:core/Models/User.dart';
import 'package:core/Models/BaseModel.dart';
import 'package:core/Utils/Const.dart';
import 'package:core/Utils/Prefs.dart';
import 'package:core/Utils/rest_api.dart';
import 'package:flutter/material.dart';

/*void getPrivacyPolicy(
    {required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Get,
      endPoint: Const.PRIVACY_POLICY,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

void getTermCondition(
    {required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Get,
      endPoint: Const.TERMS_CONDITION,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}*/

Future<void> login(
    {required String email,
    required String password,
    String? device_token,
    required Function(User user) onSuccess,
    required Function(String error) onError}) async {
  /*Future.delayed(Duration(seconds: 2), () {
    var data = {
      "id": 1,
      "first_name": "John",
      "last_name": "Doe",
      "email": "john.john@yopmail.com",
      "phone": "1",
      "nic": "1",
      "is_active": true,
      "token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTY0MjA4MjA4OSwiZXhwIjozZSs1OX0.WLVRxHLkwEOrQiGSwSSBhDlEtjQE9-li3RXKv_899lU"
    };
    User user = User.fromJson(data);
    Prefs.setUser(user);
    onSuccess(user);
  });
  return;*/
  invokeAsync(
      method: Method.Post,
      endPoint: Const.SIGNIN_ENDPOINT,
      body: {
        'email': email,
        'password': password,
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'device_token': device_token ?? 'N/A',
      },
      onSuccess: (BaseModel basemodel) {
        User user = User.fromJson(basemodel.data);
        Prefs.setUser(user);
        onSuccess(user);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> signUp(
    {required String name,
    required String dob,
    required String email,
    required String mobile_no,
    required String password,
    required String confirm_password,
    required String gender,
    String? device_token,
    String? imagePath,
    required Function(User user) onSuccess,
    required Function(String error) onError}) async {
  /*Future.delayed(Duration(seconds: 2), () {
    var data = {
      "id": 1,
      "first_name": "John",
      "last_name": "Doe",
      "email": "john.john@yopmail.com",
      "phone": "1",
      "nic": "1",
      "is_active": true,
      "token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTY0MjA4MjA4OSwiZXhwIjozZSs1OX0.WLVRxHLkwEOrQiGSwSSBhDlEtjQE9-li3RXKv_899lU"
    };
    User user = User.fromJson(data);
    Prefs.setUser(user);
    onSuccess(user);
  });
  return;*/
  invokeAsync(
      method: Method.Multipart,
      endPoint: Const.SIGNUP_ENDPOINT,
      body: {
        "name": name,
        "date_of_birth": dob,
        "email": email, //"email@yopmail.com",
        "mobile_no": "+1-$mobile_no",
        "gender": gender,
        "password": password, //"Admin@123",
        "confirm_password": password, //"Admin@123",//password,
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'device_token': device_token ?? 'N/A',
      },
      image: imagePath,
      onSuccess: (BaseModel basemodel) {
        User user = User.fromJson(basemodel.data);
        Prefs.setUser(user);
        onSuccess(user);
      },
      onError: (String error) {
        onError(error);
      });
}

void uploadFile(
    {required String type,
    required String authToken,
    required List<String> image,
    required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Multipart,
      endPoint: Const.UPLOAD_FILE,
      files: image,
      body: {
        "type": type,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

void logOutUser(
    {required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint: Const.LOGOUT,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> updateUser(
    {required String name,
    required String dob,
    required String email,
    required String mobile_no,
    required String gender,
    String? imagePath,
    required Function(User user) onSuccess,
    required Function(String error) onError}) async {
  /*Future.delayed(Duration(seconds: 2), () {
    Prefs.getUser((user) => onSuccess(user));
  });
  return;*/
  User? user = await Prefs.getUserSync();
  invokeAsync(
      method: Method.Multipart,
      endPoint: Const.UPDATE_USER_ENDPOINT,
      body: {
        "_method": "PUT",
        "name": name,
        "date_of_birth": dob,
        // "email": email,
        "mobile_no": "+1-$mobile_no",
        "gender": gender,
        // 'device_type': Platform.isAndroid ? 'android' : 'ios',
        // 'device_token': device_token??'N/A',
      },
      image: imagePath,
      pathVariable: user?.slug,
      onSuccess: (BaseModel basemodel) {
        User user = User.fromJson(basemodel.data);
        Prefs.getUser((savedUser) {
          user.api_token = savedUser!.api_token;
          Prefs.setUser(user);
          onSuccess(user);
        });
      },
      onError: (String error) {
        onError(error);
      });
}

void forgetPassword(
    {required String email,
    required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint: Const.FORGOT_PASSWORD,
      body: {
        'email': email,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

void changePassword(
    {required String oldPassword,
    required String newPassword,
    required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint: Const.CHANGE_PASSWORD,
      body: {
        "current_password": oldPassword,
        "new_password": newPassword,
        "confirm_password": newPassword,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getProfile(
    {required Function(User user) onSuccess,
    required Function(String error) onError}) async {
  User? user = await Prefs.getUserSync();
  invokeAsync(
      method: Method.Get,
      endPoint: Const.GET_PROFILE,
      pathVariable: user?.slug,
      onSuccess: (BaseModel basemodel) {
        User user = User.fromJson(basemodel.data);
        onSuccess(user);
      },
      onError: (String error) {
        onError(error);
      });
}

void createFIR(
    {required String subject,
    required String desc,
    required String address,
    required String stationId,
    List<String>? images,
    required Function(String message) onSuccess,
    required Function(String error) onError}) {
  // subject:Attempt to murder
  // address:Block 6 defence
  // descriptions:Lorem description for the case Lorem description for the case
  // station_id:1
  invokeAsync(
      method: Method.Multipart,
      endPoint: Const.CREATE_FIR,
      body: {
        "subject": subject,
        "descriptions": desc,
        "address": address,
        "station_id": stationId,
      },
      files: images,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel.message);
      },
      onError: (String error) {
        onError(error);
      });
}

void getStations(
    {required Function(List<Station> stations) onSuccess,
    required Function(String error) onError}) {
  // Future.delayed(Duration(seconds: 2),(){});
  /*Future.delayed(Duration(seconds: 2), () {
    var data = {
      "stations": [
        {
          "id": 1,
          "name": "Nazimabad",
          "address": "Nazimabad",
          "ptcl": "12457",
          "is_active": true,
          "is_deleted": 0,
          "created_at": "2022-01-09 12:38:32",
          "updated_at": "2022-01-09 12:38:32"
        },
        {
          "id": 2,
          "name": "Garden",
          "address": "Garden Garden ",
          "ptcl": "12457",
          "is_active": true,
          "is_deleted": 0,
          "created_at": "2022-01-09 12:38:32",
          "updated_at": "2022-01-09 12:38:32"
        }
      ]
    };
    List<Station> stations = [];
    data['stations'].forEach((v) {
      stations.add(Station.fromJson(v));
    });
    onSuccess(stations);
  });
  return;*/
  invokeAsync(
      method: Method.Get,
      endPoint: 'app/data',
      onSuccess: (BaseModel basemodel) {
        List<Station> stations = [];
        if (basemodel.data['stations'] != null) {
          basemodel.data['stations'].forEach((v) {
            stations.add(Station.fromJson(v));
          });
          onSuccess(stations);
        } else
          onSuccess(stations);
      },
      onError: (String error) {
        onError(error);
      });
}

void getMyFirs(
    {required Function(List<AnotherSampleModel> firs) onSuccess,
    required Function(String error) onError}) {
  // Future.delayed(Duration(seconds: 2),(){});
  invokeAsync(
      method: Method.Get,
      endPoint: 'firs',
      onSuccess: (BaseModel basemodel) {
        List<AnotherSampleModel> list = [];
        if (basemodel.data != null) {
          basemodel.data.forEach((v) {
            list.add(AnotherSampleModel.fromJson(v));
          });
          onSuccess(list);
        } else
          onSuccess(list);
      },
      onError: (String error) {
        onError(error);
      });
}

void logout(
    {required String authToken,
    required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint: Const.LOGOUT,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}
