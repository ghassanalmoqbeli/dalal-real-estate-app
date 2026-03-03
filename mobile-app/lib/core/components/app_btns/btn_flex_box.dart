import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/components/app_btns/btn_helpers.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_colors.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:flutter/material.dart';

class BtnFlexBox extends StatelessWidget {
  const BtnFlexBox({
    super.key,
    this.radius,
    this.onTap,
    this.btnCols,
    required this.btnSize,
    this.deco,
    required this.child,
  });
  final double? radius;
  final void Function()? onTap;
  final XBSize btnSize;
  final XBColors? btnCols;
  final Decoration? deco;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: Funcs.frwGetter(btnSize.width, context),
        child: AspectRatio(
          aspectRatio: Funcs.aspGetter(btnSize),
          child: Container(
            decoration:
                deco ??
                BtnHelpers.btn(
                  btnSize.radius,
                  colors: btnCols,
                  borderWidth: btnSize.border,
                ),
            child: child,
          ),
        ),
      ),
    );
  }
}
