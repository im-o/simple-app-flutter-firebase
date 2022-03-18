import 'package:flutter/material.dart';

import '../../core.dart';

class ContentSheet extends StatelessWidget {
  const ContentSheet({
    Key? key,
    required this.content,
    this.height,
    this.expandContent = true,
  }) : super(key: key);

  final Widget content;
  final double? height;
  final bool expandContent;

  @override
  Widget build(BuildContext context) {
    if (expandContent == true) {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              _buildIndicator(context),
              Expanded(
                child: content,
              ),
            ],
          ),
        ),
      );
    } else {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: (Dimens.width(context) / 2) - 40),
              child: _buildIndicator(context),
            ),
            content,
          ],
        ),
      );
    }
  }

  Widget _buildIndicator(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.dp16, bottom: Dimens.dp24),
      width: 80,
      height: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(Dimens.dp4),
      ),
    );
  }
}
