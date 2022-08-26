// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// // import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:iprowide/Utils/Prefs.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//
// Future<Null> facebookLogIn(
//     /*FacebookLogin facebookLogin,*/
//     Function(SocialUser) success,
//     Function(String) error) async {
//   /*// Let's force the users to login using the login dialog based on WebViews. Yay!
//   // facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
//   final FacebookLoginResult result =
//       await facebookLogin.logIn(['email', 'public_profile']);
//
//   switch (result.status) {
//     case FacebookLoginStatus.loggedIn:
//       final FacebookAccessToken accessToken = result.accessToken;
//       print('''
//          Facebook Logged in!
//
//          Token: ${accessToken.token}
//          User id: ${accessToken.userId}
//          ''');
//       final token = accessToken.token;
//       final graphResponse = await http.get(Uri.parse(
//           'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=$token'));
//       final profile = json.decode(graphResponse.body);
//
//       print("FB: ${profile.toString()}");
//
//       SocialUser socialUser = SocialUser();
//       socialUser.socialID = accessToken.userId;
//       socialUser.name = profile["name"];
//       socialUser.firstName = profile["first_name"];
//       socialUser.lastName = profile["last_name"];
//       socialUser.email = profile["email"];
//       socialUser.profilePicture = profile["picture"]["data"]["url"];
//       socialUser.socialPlatform = describeEnum(SOCIAL_PLATFORM.FACEBOOK);
//
//       if (accessToken.token != null) {
//         success(socialUser);
//       }
//       // if (await facebookLogin.isLoggedIn) facebookLogin.logOut();//Disabled for Testing
//       break;
//
//     case FacebookLoginStatus.cancelledByUser:
//       // setState(() => _isFacebookLoggedIn = false);
//       print('Login cancelled by the user.');
//       // error("cancelled");
//       break;
//
//     case FacebookLoginStatus.error:
//       // setState(() => _isFacebookLoggedIn = false);
//       String issue = 'Something went wrong with the login process.\n'
//           'Here\'s the error Facebook gave us: ${result.errorMessage}';
//       print(issue);
//       error(issue);
//       break;
//   }*/
//   /*--------------------------------------------------------------------*/
//   final LoginResult result = await FacebookAuth.instance
//       .login(); // by default we request the email and the public profile
// // or FacebookAuth.i.login()
//   if (result.status == LoginStatus.success) {
//     // you are logged
//     final AccessToken accessToken = result.accessToken;
//     // get the user data
//     // by default we get the userId, email,name and picture
//     final profile = await FacebookAuth.instance.getUserData();
//     print("FB: ${profile.toString()}");
//
//     SocialUser socialUser = SocialUser();
//     socialUser.socialID = accessToken.userId;
//     socialUser.name = profile["name"];
//     socialUser.firstName = profile["first_name"];
//     socialUser.lastName = profile["last_name"];
//     socialUser.email = profile["email"];
//     socialUser.profilePicture = profile["picture"]["data"]["url"];
//     socialUser.socialPlatform = describeEnum(SOCIAL_PLATFORM.FACEBOOK);
//
//     if (accessToken.token != null) {
//       success(socialUser);
//     }
//     //Logout
//     await FacebookAuth.instance.logOut();
//   } else {
//     print(result.status);
//     print(result.message);
//     error(result.message);
//   }
//
// //   //check if logged-in
// //   final AccessToken accessToken = await FacebookAuth.instance.accessToken;
// // // or FacebookAuth.i.accessToken
// //   if (accessToken != null) {
// //     // user is logged
// //   }
// }
//
// Future<Null> googleLogin(
//     Function(SocialUser) success, Function(String) error) async {
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: <String>['email'],
//   );
//
//   try {
//     var googleSignInAccount = await _googleSignIn.signIn();
//     print("Gmail: ${googleSignInAccount.toString()}");
//
//     if (googleSignInAccount != null) {
//       SocialUser socialUser = SocialUser();
//       socialUser.socialID = googleSignInAccount.id;
//       socialUser.name = googleSignInAccount.displayName;
//       // socialUser.firstName = profile["first_name"];
//       // socialUser.lastName = profile["last_name"];
//       socialUser.email = googleSignInAccount.email;
//       socialUser.profilePicture = googleSignInAccount.photoUrl;
//       socialUser.socialPlatform = describeEnum(SOCIAL_PLATFORM.GMAIL);
//
//       if (googleSignInAccount.id != null) {
//         success(socialUser);
//         _googleSignIn.disconnect(); //Disabled for Testing
//       }
//     } else {
//       // error("cancelled");
//     }
//   } catch (e) {
//     print(e);
//     error(e.toString());
//   }
// }
//
// Future<Null> appleLogin(
//     Function(SocialUser) success, Function(String) error) async {
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: <String>['email'],
//   );
//
//   try {
//     final credential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );
//
//     print(credential);
//     SocialUser socialUser = SocialUser();
//     socialUser.socialID = credential.userIdentifier;
//     socialUser.name = "${credential.givenName} ${credential.familyName}";
//     socialUser.email = credential.email;
//     socialUser.socialPlatform = describeEnum(SOCIAL_PLATFORM.APPLE);
//     SocialUser savedUser = await Prefs.getAppleCredentials;
//     if (socialUser.email != null) {
//       Prefs.setAppleCredentials(socialUser);
//       success(socialUser);
//     } else if (savedUser != null && savedUser.socialID == socialUser.socialID) {
//       success(savedUser);
//     } else
//       success(socialUser);
//   } catch (e) {
//     print(e);
//     if (e.runtimeType == SignInWithAppleAuthorizationException) {
//       SignInWithAppleAuthorizationException exception =
//           e as SignInWithAppleAuthorizationException;
//       if (exception.code != AuthorizationErrorCode.canceled)
//         error(e.toString());
//     }
//   }
// }

class SocialUser {
  String? socialID,
      name,
      firstName,
      lastName,
      email,
      profilePicture,
      age,
      gender,
      socialPlatform;

  SocialUser(
      {this.socialID,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.profilePicture,
      this.age,
      this.gender,
      this.socialPlatform});

  Map<String, dynamic> toMap() {
    return {
      "socialID": socialID,
      "name": name,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "profilePicture": profilePicture,
      "age": age,
      "gender": gender,
      "socialPlatform": socialPlatform,
    };
  }

  SocialUser.fromJson(Map<String, dynamic> json) {
    socialID = json['socialID'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    age = json['age'];
    gender = json['gender'];
    socialPlatform = json['socialPlatform'];
  }
}

enum SOCIAL_PLATFORM {
  FACEBOOK,
  GMAIL,
  APPLE,
}
