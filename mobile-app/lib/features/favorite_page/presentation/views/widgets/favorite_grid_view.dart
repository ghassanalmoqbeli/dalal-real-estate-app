import 'package:dallal_proj/core/components/app_cards/property_card/h_card/h_card_item_builder.dart';
import 'package:dallal_proj/core/constants/wid_lists.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class FavoriteGridView extends StatelessWidget {
  const FavoriteGridView({super.key, required this.favList});
  final List<ShowDetailsEntity> favList;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: favList.length,
      physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.only(top: 30, bottom: 30, right: 2, left: 2),
      gridDelegate: CLwid.kGridDelegate(context),
      itemBuilder: (context, index) {
        return HCardItemBuilder(advsListItem: favList[index]);
      },
    );
  }
}
