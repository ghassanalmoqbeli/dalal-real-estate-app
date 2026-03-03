import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_image/card_property_image.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/v_card/v_card_gen_det_sect.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class VCardForm extends StatelessWidget {
  const VCardForm({super.key, required this.detailsEntity});
  final ShowDetailsEntity detailsEntity;
  // final DetailsArgs detailsArgs;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLikedNotifier = ValueNotifier(
      detailsEntity.isLiked,
    );
    return TwoItmRow(
      mXAlign: MainAxisAlignment.end,
      leftChild: Expanded(
        child: VCardGenDetSect(
          onDetails: () => Funcs.pushToAdv(context, detailsEntity),
          detailsEntity: detailsEntity,
          isLikedNotifier: isLikedNotifier,
        ),
      ),
      rightChild: HPItem(
        lSpc: 11,
        child: CardPropertyImage(advListItem: detailsEntity, aspect: 0.829),
      ),
    );
  }
}
