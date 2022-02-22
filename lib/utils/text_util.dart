import 'package:flutter/material.dart';

import 'color_util.dart';

abstract class TextUtil {
  static const TextStyle textStyle18 = TextStyle(
    color: ColorUtil.blackPrime,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle16 = TextStyle(
    color: ColorUtil.blackPrime,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle12 = TextStyle(
    color: ColorUtil.blackPrime,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textStyle10 = TextStyle(
    color: ColorUtil.black300,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}
