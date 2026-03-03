import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class ShortHeaderLbl extends StatelessWidget {
  const ShortHeaderLbl({super.key, this.onTap, required this.lblModel});
  final void Function()? onTap;
  final LblModel lblModel;
  @override
  Widget build(BuildContext context) {
    return ShortHeaderLblBox(
      decoration: lblModel.deco,
      onTap: onTap,
      child: lblModel.lblRow,
    );
  }
}

class ShortHeaderLblBox extends StatelessWidget {
  const ShortHeaderLblBox({
    super.key,
    this.onTap,
    required this.child,
    required this.decoration,
  });
  final void Function()? onTap;
  final Decoration decoration;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: Funcs.respWidth(fract: 0.384, context: context),
          height: 33,
          padding: const EdgeInsets.only(left: 4, bottom: 3),
          margin: const EdgeInsets.only(right: 4),
          decoration: decoration,
          child: child,
        ),
      ),
    );
  }
}
