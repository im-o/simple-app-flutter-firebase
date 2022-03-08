import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  const RegularText(
    this.text, {
    Key? key,
    this.style,
    this.maxLine,
    this.overflow,
    this.align,
  }) : super(key: key);

  factory RegularText.normalSolid(
    BuildContext context,
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLine,
    TextOverflow? overflow,
    TextAlign? align,
  }) {
    return RegularText(
      text,
      key: key,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        color: Theme.of(context).textTheme.headline5?.color,
      ).merge(style),
      align: align,
      maxLine: maxLine,
      overflow: overflow,
    );
  }

  factory RegularText.mediumSolid(
    BuildContext context,
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLine,
    TextOverflow? overflow,
    TextAlign? align,
  }) {
    return RegularText(
      text,
      key: key,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Theme.of(context).textTheme.headline5?.color,
      ).merge(style),
      align: align,
      maxLine: maxLine,
      overflow: overflow,
    );
  }

  factory RegularText.semiBoldSolid(
    BuildContext context,
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLine,
    TextOverflow? overflow,
    TextAlign? align,
  }) {
    return RegularText(
      text,
      key: key,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.headline5?.color,
      ).merge(style),
      align: align,
      maxLine: maxLine,
      overflow: overflow,
    );
  }

  final String text;
  final TextStyle? style;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    final _baseStyle = Theme.of(context).textTheme.bodyText2;

    return Text(
      text,
      style: _baseStyle?.merge(style),
      maxLines: maxLine,
      overflow: overflow,
      textAlign: align,
    );
  }
}
