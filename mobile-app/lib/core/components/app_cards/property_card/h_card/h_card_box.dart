import 'package:dallal_proj/core/components/app_cards/property_card/items/property_card_helper.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class HCardBox extends StatelessWidget {
  const HCardBox({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Funcs.frwGetter(200, context),
      child: AspectRatio(
        aspectRatio:
            Funcs.frwGetter(193.3407, context) / Funcs.frhGetter(289, context),
        child: Container(
          padding: PCardH.hItemPadding(),
          decoration: Themer.bard(null, radius: 12),
          child: child,
        ),
      ),
    );
  }
}
