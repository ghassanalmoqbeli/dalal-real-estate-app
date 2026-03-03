import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:flutter/material.dart';

class CardTitleWid extends StatelessWidget {
  const CardTitleWid({super.key, required this.text, this.style});
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return HPItem(
      rSpc: 5,
      child: SizedBox(
        width: Funcs.frwGetter(150, context),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            text,
            style: style?.copyWith(height: 1.5),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ); //rSpc: itSpc ?? 5),
  }
}
