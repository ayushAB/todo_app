import 'package:flutter/material.dart';

import '../config.dart';

class AppStyle {
  static ButtonStyle AppButtonStyle() {
    return ButtonStyle(
        elevation: MaterialStateProperty.all<double>(6.0),
        backgroundColor:
            MaterialStateProperty.all<Color>(AppColors().mainColor(1.0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )));
  }
}
