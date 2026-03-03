import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:flutter/material.dart';

class FilterFormItem extends StatelessWidget {
  const FilterFormItem({
    super.key,
    required this.title,
    required this.child,
    this.height = 72,
    this.style,
  });
  final String title;
  final double? height;
  final Widget child;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return TwoItmCol(
      cXAlign: CrossAxisAlignment.end,
      topChild: RText(title, style ?? FStyles.s14w6, txtAlign: WidH.tra),
      btmChild: SizedBox(height: height, child: child),
    );
  }
}
