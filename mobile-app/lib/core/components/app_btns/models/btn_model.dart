import 'package:dallal_proj/core/components/app_btns/models/x_b_colors.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BtnModel {
  final String text;
  final void Function()? onPressed;
  final XBSize btnSize;
  final XBColors btnColors;
  final TextStyle? txtStyle;
  final Decoration? deco;
  BtnModel({
    this.txtStyle,
    this.deco,
    this.btnSize = const XBSize(height: 56, width: 177),
    this.btnColors = const XBColors(
      txt: kWhite,
      border: kTransP,
      fill: kPrimColG,
    ),
    required this.text,
    required this.onPressed,
  });
}
