import 'package:dallal_proj/core/components/app_cards/property_card/h_card/h_card_box.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/h_card/h_card_form.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class HCardItem extends StatelessWidget {
  const HCardItem({
    super.key,
    required this.advsListItem,
    this.isMyAdvScreen = false,
    this.onPressedFav,
  });
  final ShowDetailsEntity advsListItem;
  final bool isMyAdvScreen;
  final void Function()? onPressedFav;

  @override
  Widget build(BuildContext context) {
    return HCardBox(
      child: HCardForm(
        advsListItem: advsListItem,
        isMine: isMyAdvScreen,
        onPressedFav: onPressedFav,
      ),
    );
  }
}
