import 'package:dallal_proj/core/components/app_cards/property_card/h_card/build_h_card_form.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/h_card/h_card_btn_switcher.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class HCardForm extends StatelessWidget {
  const HCardForm({
    super.key,
    required this.advsListItem,
    this.isMine = false,
    this.onPressedFav,
  });
  final ShowDetailsEntity advsListItem;
  final void Function()? onPressedFav;

  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLikedNotifier = ValueNotifier(
      advsListItem.isLiked,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: buildHCardForm(
        onPressedFav: onPressedFav,
        advsListItem,
        child: HCardBtnsSwitcher(
          detailsEntity: advsListItem,
          isMine: isMine,
          isLikedNotifier: isLikedNotifier,
        ),
      ),
    );
  }
}
