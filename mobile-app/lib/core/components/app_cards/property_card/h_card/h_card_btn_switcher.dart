import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/h_card/my_adv_seperated_btns.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_btns/card_seperated_btns.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class HCardBtnsSwitcher extends StatelessWidget {
  const HCardBtnsSwitcher({
    super.key,
    required this.detailsEntity,
    this.isMine = false,
    required this.isLikedNotifier,
  });
  final ShowDetailsEntity detailsEntity;
  final bool isMine;
  final ValueNotifier<bool> isLikedNotifier;

  @override
  Widget build(BuildContext context) {
    return isMine
        ? MyAdvSeperatedBtns(detailsEntity: detailsEntity)
        : CardSeperatedBtns(
          rMXAlign: MainAxisAlignment.spaceAround,
          moreBtnSize: const XBSize(width: 83.5429, height: 29),
          likeBtnSize: const XBSize(width: 83, height: 29),
          detailsEntity: detailsEntity,
          onTapDetails: () => Funcs.pushToAdv(context, detailsEntity),
          onTapLikes: () {},
          isLikedNotifier: isLikedNotifier,
        );
  }
}
