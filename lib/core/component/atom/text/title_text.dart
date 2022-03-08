import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
    this.text, {
    Key? key,
    this.style,
    this.maxLine,
    this.overflow,
    this.align,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    final _baseStyle = Theme.of(context).textTheme.headline6;

    return Text(
      text,
      style: _baseStyle?.merge(style),
      maxLines: maxLine,
      overflow: overflow,
      textAlign: align,
    );
  }
}
