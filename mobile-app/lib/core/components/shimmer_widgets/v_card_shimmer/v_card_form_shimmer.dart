import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_property_image_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/v_card_shimmer/v_card_gen_det_sect_shimmer.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class VCardFormShimmer extends StatelessWidget {
  const VCardFormShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const TwoItmRow(
      mXAlign: MainAxisAlignment.end,
      leftChild: Expanded(child: VCardGenDetSectShimmer()),
      rightChild: HPItem(
        lSpc: 11,
        child: CardPropertyImageShimmer(aspect: 0.829),
      ),
    );
  }
}
