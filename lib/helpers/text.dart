import 'package:flutter/material.dart';

const double textFactorMax = 0.4;
double getTheTextFactorFix(BuildContext context) {
  var r = MediaQuery.of(context).size.width * 0.0011;
  if (r > textFactorMax) r = textFactorMax;
  double factor = 2.5;
  if (MediaQuery.of(context).size.width < 600) factor = 2.1;
  // return r * factor;
  return r * factor;
}
