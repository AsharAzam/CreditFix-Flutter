import 'package:flutter/material.dart';

class ScreenConfig {
  static late MediaQueryData _mediaQueryData;
  static late  double screenWidth; //Actual screen Width
  static late  double screenHeight; //Actual screen Height
  static late  double horizontalPercent; //1% of width
  static late  double verticalPercent; //1% of height

  static late  double _safeAreaHorizontal;
  static late  double _safeAreaVertical;
  static late  double safeHorizontalPercent; //1% of width excluded safe area
  static late  double safeVerticalPercent; //1% of height excluded safe area

  static late bool isDarkMode;//[isDarkMode] = true when dark mode is enabled

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    horizontalPercent = screenWidth / 100;
    verticalPercent = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeHorizontalPercent = (screenWidth - _safeAreaHorizontal) / 100;
    safeVerticalPercent = (screenHeight - _safeAreaVertical) / 100;

    var brightness = _mediaQueryData.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
  }

  @override
  static void printSizeConfig() {
    return print(
        'SizeConfig{screenWidth: $screenWidth, screenHeight: $screenHeight}');
  }
}
