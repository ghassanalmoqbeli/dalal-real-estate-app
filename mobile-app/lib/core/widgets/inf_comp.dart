import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/h_p_text.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:flutter/material.dart';

class InfComp extends StatelessWidget {
  const InfComp({
    super.key,
    required this.title,
    required this.child,
    this.spacing,
    this.hpadding,
    this.txtRightPadding,
    this.titleStyle,
    this.cXAl,
  });
  final String title;
  final TextStyle? titleStyle;
  final double? spacing;
  final double? hpadding, txtRightPadding;
  final Widget child;
  final CrossAxisAlignment? cXAl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hpadding ?? 0.0),
      child: TwoItmCol(
        cXAlign: cXAl ?? CrossAxisAlignment.end,
        topChild: VPItem(
          bSpc: spacing ?? 6,
          child: HPText(
            rSpc: txtRightPadding ?? 0,
            txt: title,
            style: FsC.htStyle(titleStyle ?? FStyles.s16w6h175, 1.25),
          ),
        ),
        btmChild: child,
      ),
    );
  }
}
