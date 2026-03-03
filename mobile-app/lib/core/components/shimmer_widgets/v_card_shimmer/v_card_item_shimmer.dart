import 'package:dallal_proj/core/components/app_cards/property_card/items/property_card_helper.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/v_card_shimmer/v_card_form_shimmer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class VCardItemShimmer extends StatelessWidget {
  const VCardItemShimmer({super.key});
  // final ShowDetailsEntity cardModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PCardH.vItemPadding(),
      height: 207,
      decoration: Themer.bard(null, radius: 12),
      child: const VCardFormShimmer(),
    );
  }
}
