import 'package:dallal_proj/core/components/app_cards/property_card/items/property_card_helper.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/v_card/v_card_form.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class VCardItem extends StatelessWidget {
  const VCardItem({super.key, required this.cardModel});
  final ShowDetailsEntity cardModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PCardH.vItemPadding(),
      height: 207,
      decoration: Themer.bard(null, radius: 12),
      child: VCardForm(detailsEntity: cardModel),
    );
  }
}
