import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class CustSeperator extends StatelessWidget {
  const CustSeperator({super.key, this.width});
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 1.0,
        width: width ?? Funcs.respWidth(fract: 0.379, context: context),
        color: kWhite2E,
      ),
    );
  }
}
