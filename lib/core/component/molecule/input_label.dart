import 'package:flutter/material.dart';

import '../../core.dart';
import '../../preferences/preferences.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    Key? key,
    this.label,
    this.isRequired,
  }) : super(key: key);

  final String? label;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    if (label == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RegularText.mediumSolid(context, label ?? ''),
            const SizedBox(width: Dimens.dp8),
            isRequired == true
                ? RegularText(
                    // TODO- | context.l10n.required,
                    'Form required',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimens.dp10,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: Dimens.dp8),
      ],
    );
  }
}
