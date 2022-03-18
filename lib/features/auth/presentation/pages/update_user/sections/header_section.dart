import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/core.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(MainAssets.loginHeaderSvg),
        const SizedBox(height: Dimens.dp24),
        const TitleText('Hey,\nThis Update User Page,'),
      ],
    );
  }
}
