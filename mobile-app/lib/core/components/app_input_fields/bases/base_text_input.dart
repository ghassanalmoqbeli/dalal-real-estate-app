import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BTextInput extends StatelessWidget {
  const BTextInput({
    super.key,
    this.textStyle,
    required this.isEnabled,
    required this.onChanged,
    required this.onSubmitted,
    this.maxLines,
    this.decoration,
    this.rdOnly,
    this.txt,
    this.controller,
  });
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final int? maxLines;
  final String? txt;
  final TextStyle? textStyle;
  final bool? isEnabled, rdOnly;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ?? TextEditingController(text: txt ?? ''),
      readOnly: rdOnly ?? false,
      maxLines: maxLines ?? 1,
      textAlignVertical: TextAlignVertical.center,
      textAlign: WidH.tra,
      textDirection: WidH.trd,
      style: textStyle ?? const TextStyle(color: kBlack),
      enabled: isEnabled ?? true,
      decoration: decoration ?? const InputDecoration(),
      onChanged: onChanged ?? (text) {},
      onSubmitted: onSubmitted ?? (text) {},
    );
  }
}
