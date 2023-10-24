import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

class ColorName {
  ColorName._();
  static const Color blue = Color.fromARGB(255, 14, 119, 247);

  /// Color: #000000
  static const Color black = Color(0xFF000000);

  /// Color: #484848
  static const Color darkGrey = Color(0xFF484848);

  /// Color: #008489
  static const Color green = Color(0xFF008489);

  /// Color: #767676
  static const Color grey = Color(0xFF767676);

  /// Color: #C4C4C4
  static const Color lightGrey = Color(0xFFC4C4C4);

  /// Color: #914669
  static const Color purple = Color(0xFF914669);

  /// Color: #FF5A5F
  static const Color red = Color(0xFFFF5A5F);

  /// Color: #C4C4C4
  static const Color shadowGrey = Color(0xFFC4C4C4);

  /// Color: #FFFFFF
  static const Color white = Color(0xFFFFFFFF);
}

class ApplicationConstants {
  static const EMAIL_REGIEX = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$';

  static const LANG_ASSET_PATH = 'assets/lang';
}
