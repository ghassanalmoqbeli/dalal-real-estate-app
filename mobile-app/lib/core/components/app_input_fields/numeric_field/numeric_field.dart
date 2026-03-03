import 'package:flutter/material.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/components/app_input_fields/numeric_input.dart';
import 'package:dallal_proj/core/components/app_input_fields/numeric_field/numeric_field_box.dart';

class NumericField extends StatelessWidget {
  ///It must be wrapped with:
  ///Container(height) -> [Row] -> [NumericInput] ([aspect])
  ///
  ///Container
  /// (
  ///  req [int] height fixed,
  ///  opt [aspect],
  ///  req [Row]
  ///   (
  ///     opt [aspect],
  ///     req [NumericField] (req [hint], req [aspect])
  ///   )
  /// )
  const NumericField({
    super.key,
    required this.hint,
    this.leftPadding,
    this.rightPadding,
    required this.aspect,
    this.mLength,
    this.hintStyle,
    this.keyboardType,
    this.tAln,
    this.tDir,
    this.style,
    this.mxL,
    this.deco,
    this.controller,
    this.onChanged,
  });
  final double aspect;
  final String hint;
  final double? leftPadding, rightPadding;
  final int? mLength;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final TextAlign? tAln;
  final TextDirection? tDir;
  final TextStyle? style;
  final int? mxL;
  final InputDecoration? deco;
  final TextEditingController? controller;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumericFieldBox(
        leftPadding: leftPadding ?? 0,
        rightPadding: rightPadding ?? 0,
        aspect: aspect,
        child: NumericInput(
          controller: controller,
          tAln: tAln,
          tDir: tDir,
          mxL: mxL,
          mLength: mLength,
          style: style,
          keyboardType: keyboardType,
          deco: Themer.numInput(hint, hintStyle: hintStyle),
          // onChanged: (value) {},
          onChanged: (value) {
            onChanged?.call();
          },
        ),
      ),
    );
  }
}
