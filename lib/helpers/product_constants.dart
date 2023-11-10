import 'package:flutter/material.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';

class ProductConstants {
  static final ProductConstants _instance = ProductConstants._init();
  static ProductConstants get instance => _instance;
  ProductConstants._init();

  List<BoxShadow> get defaultShadow => [
        BoxShadow(
            blurRadius: 15,
            spreadRadius: 0,
            color: ColorName.black.withOpacity(.15))
      ];

  List<String> get filterNames => [
        "filter_variables_design",
        "filter_variables_omg",
        "filter_variables_surfing",
        "filter_variables_arctic",
        "filter_variables_tropical",
        "filter_variables_windmills",
      ];

  List<String> get filterIcons => [
        Assets.icon.icDesign.path,
        Assets.icon.icOmg.path,
        Assets.icon.icSurfing.path,
        Assets.icon.icArctic.path,
        Assets.icon.icTropical.path,
        Assets.icon.icWindmills.path,
      ];
}
