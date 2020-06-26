import 'package:flutter/material.dart';

class ResponsiveScreen {
  static final ResponsiveScreen _singleton = ResponsiveScreen._internal();

  factory ResponsiveScreen() {
    return _singleton;
  }

  ResponsiveScreen._internal();
//mediaQurey.of(context)   מציג מידות של פלאפון שרצץ עליו עכשו
  double widthMediaQuery(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * width / 360;// רוחב של פריט
  }

  double heightMediaQuery(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * height / 640;
  }
}
