import 'package:flutter/material.dart';

class AppColors{
  static const Color appPrimary = Color(0xff060c12);
  static const Color red = Colors.red;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color orangeAccent = Colors.orangeAccent;
  static const Color shadow = Color(0xff183E5D);


  static const LinearGradient appGradient = LinearGradient(
    colors: [
      Color(0xff2b2625),
      Color(0xff1a283a),
      Color(0xff212930),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient appGradient2 = LinearGradient(
    colors: [
      Color(0xff1D1E26),
      Color(0xff2b3d51),
      Color(0xff1c2229),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

}