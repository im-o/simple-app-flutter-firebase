import 'package:flutter/material.dart';

import '../../component.dart';

class SearchTextInput extends StatelessWidget {
  const SearchTextInput({
    Key? key,
    required this.controller,
    this.hint,
    this.onClear,
    this.onChanged,
    this.onSubmit,
    this.readOnly,
    this.onTap,
    this.focusNode,
    this.autoFocus,
    this.enable,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hint;
  final VoidCallback? onClear;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final bool? readOnly;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return RegularInput(
      hintText: hint,
      focusNode: focusNode,
      controller: controller,
      prefixIcon: Icons.search,
      onChange: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      autoFocus: autoFocus,
      onSubmit: onSubmit,
      enable: enable,
      suffix: controller.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                if (onClear != null) {
                  onClear!();
                }
                onChanged?.call('');
              },
            )
          : null,
    );
  }
}
