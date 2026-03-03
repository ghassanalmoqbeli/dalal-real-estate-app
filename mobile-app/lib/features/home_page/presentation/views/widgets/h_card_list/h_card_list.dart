import 'package:dallal_proj/core/components/app_cards/property_card/h_card/h_card_item_builder.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class HCardList extends StatelessWidget {
  const HCardList({super.key, required this.advsList, this.onPressedFav});
  final List<ShowDetailsEntity> advsList;
  final void Function()? onPressedFav;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Funcs.respHieght(fract: 0.39, context: context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: advsList.length,
        itemBuilder: (context, index) {
          final adv = advsList[index];
          return Padding(
            padding: const EdgeInsets.only(
              left: 6.66,
              right: 6.66,
              top: 1,
              bottom: 1,
            ),
            child: HCardItemBuilder(
              advsListItem: adv,
              onPressedFav: onPressedFav,
              // index: index,
            ),
          );
        },
      ),
      //   },
      // ),
    );
  }
}
