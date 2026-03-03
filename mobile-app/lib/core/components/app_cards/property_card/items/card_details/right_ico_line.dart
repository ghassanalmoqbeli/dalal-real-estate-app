import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class RightIcoLine extends StatelessWidget {
  const RightIcoLine({
    super.key,
    required this.text,
    required this.icoPath,
    this.style,
    this.itSpc,
    this.icoHt,
    this.icoWth,
    this.color,
  });
  final String text, icoPath;
  final TextStyle? style;
  final Color? color;
  final double? itSpc, icoHt, icoWth;
  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: MainAxisAlignment.end,
      leftChild: HPItem(
        rSpc: 5,
        child: SizedBox(
          width: Funcs.frwGetter(150, context),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              text,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ), //rSpc: itSpc ?? 5),
      rightChild: SvgIco(
        ico: icoPath,
        ht: icoHt ?? 13,
        wth: icoWth ?? 13,
        color: color,
      ),
    );
  }
}
