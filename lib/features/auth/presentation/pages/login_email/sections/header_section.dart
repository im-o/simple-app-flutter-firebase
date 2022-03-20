import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/core.dart';
import '../../../../../../utils/utils.dart';
import '../../../../auth.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(MainAssets.loginHeaderSvg),
        const SizedBox(height: Dimens.dp24),
        const TitleText('Hey,\nLogin Now,'),
        const SizedBox(height: Dimens.dp16),
        _textRegister(context),
      ],
    );
  }

  Widget _textRegister(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'If you are new / ',
        style: TextUtil.textStyle10.copyWith(color: ColorUtil.black300),
        children: [
          TextSpan(
              text: "Register",
              style: TextUtil.textStyle12.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorUtil.colorPrimary,
                decorationColor: ColorUtil.colorPrimary,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterEmailPage(),
                  ));
                }),
        ],
      ),
    );
  }
}
