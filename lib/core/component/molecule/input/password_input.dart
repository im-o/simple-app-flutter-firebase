import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'regular_input.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.label,
    this.errorText,
    this.inputFormatters,
    this.onChange,
    this.onSubmit,
    this.inputAction,
    this.style,
    this.inputType,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? label;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChange, onSubmit;
  final TextInputAction? inputAction;
  final TextStyle? style;
  final TextInputType? inputType;
  final int? maxLength;

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return RegularInput(
      errorText: widget.errorText,
      controller: widget.controller,
      hintText: widget.hintText,
      label: widget.label,
      focusNode: widget.focusNode,
      prefixIcon: Icons.lock_outline,
      inputAction: widget.inputAction,
      inputFormatters: widget.inputFormatters,
      onChange: widget.onChange,
      onSubmit: widget.onSubmit,
      style: widget.style,
      inputType: widget.inputType ?? TextInputType.visiblePassword,
      maxLength: widget.maxLength,
      obscureText: !isVisible,
      suffix: _buildSuffix(),
    );
  }

  Widget _buildSuffix() {
    return InkWell(
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      child: Icon(isVisible
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined),
    );
  }
}
