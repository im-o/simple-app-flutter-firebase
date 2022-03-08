import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/utils.dart';
import '../../../core.dart';

class RegularInput extends StatelessWidget {
  const RegularInput({
    this.obscureText = false,
    this.focusNode,
    this.hintText,
    this.suffix,
    this.prefixIcon,
    this.controller,
    this.background,
    this.errorText,
    this.minLine = 1,
    this.maxLine = 1,
    this.onChange,
    this.onSubmit,
    this.inputAction,
    this.style,
    this.inputType,
    this.enable = true,
    this.onTap,
    this.readOnly,
    this.inputFormatters,
    this.maxLength,
    this.autoFocus,
    this.label,
    this.prefix,
    this.isRequired,
    Key? key,
  }) : super(key: key);

  final IconData? prefixIcon;
  final bool? obscureText, enable, readOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText, errorText;
  final Widget? suffix;
  final Color? background;
  final int minLine, maxLine;
  final ValueChanged<String>? onChange, onSubmit;
  final TextInputAction? inputAction;
  final TextStyle? style;
  final TextInputType? inputType;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? autoFocus;
  final String? label;
  final Widget? prefix;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(
          label: label,
          isRequired: isRequired,
        ),
        Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(
              size: Dimens.dp10,
            ),
            primaryColor: Theme.of(context).textTheme.headline5?.color,
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText ?? false,
            minLines: minLine,
            maxLines: maxLine,
            maxLength: maxLength,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            textInputAction: inputAction ?? TextInputAction.done,
            style: style ??
                const TextStyle(
                  fontSize: Dimens.dp14,
                  fontWeight: FontWeight.normal,
                ),
            keyboardType: inputType,
            enabled: enable,
            onTap: onTap,
            readOnly: readOnly ?? false,
            inputFormatters: inputFormatters,
            autofocus: autoFocus ?? false,
            decoration: InputDecoration(
              prefixIcon: (prefix != null && prefixIcon == null)
                  ? prefix
                  : (prefixIcon != null
                      ? Icon(prefixIcon, size: Dimens.dp20)
                      : null),
              counterText: '',
              hintText: hintText ?? '',
              errorText: errorText,
              suffixIcon: suffix,
              hintStyle: const TextStyle(
                color: ColorUtil.colorTextFilled,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              filled: true,
              fillColor: ColorUtil.colorFilledForm,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 1.0,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
