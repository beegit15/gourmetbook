import 'package:flutter/material.dart';
import 'package:gourmetbook/helpers/const.dart';

class themeData {
  static ThemeData theme = ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: kPrimaryColor,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      iconTheme: const IconThemeData(color: kPrimaryColor),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: kPrimaryLightColor,
        iconColor: kPrimaryColor,
        prefixIconColor: kPrimaryColor,
        contentPadding: EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none,
        ),
      ));
}
