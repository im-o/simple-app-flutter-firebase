import 'package:flutter/material.dart';

import 'color_util.dart';

abstract class TextFieldUtil {
  static const InputDecoration inputDecorationFormLogin = InputDecoration(
    hintStyle: TextStyle(
      color: ColorUtil.colorTextFilled,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    filled: true,
    fillColor: ColorUtil.colorFilledForm,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 1.0,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  );
}
