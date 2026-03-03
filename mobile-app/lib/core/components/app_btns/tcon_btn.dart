import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/components/app_btns/bases/tcon_base_btn.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_colors.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:flutter/material.dart';

class TconBtn extends TconBaseBtn {
  const TconBtn({
    super.key,
    required this.leftChild,
    required this.rightChild,
    required this.btnSize,
    this.radius,
    this.btnCols,
    this.onTap,
  });

  final double? radius;

  final Widget leftChild, rightChild;
  final XBSize btnSize;
  final XBColors? btnCols;
  final void Function()? onTap;

  @override
  Widget buildLeft(BuildContext context) => leftChild;

  @override
  Widget buildRight(BuildContext context) => rightChild;

  @override
  XBSize getSize(BuildContext context) => btnSize;

  @override
  XBColors getColors(BuildContext context) =>
      btnCols ?? const XBColors(fill: kWhiteF6);

  @override
  double? getRadius(BuildContext context) => radius ?? btnSize.radius;

  @override
  void Function()? getTap() => onTap;
}
