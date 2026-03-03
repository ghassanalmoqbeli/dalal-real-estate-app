import 'package:dallal_proj/core/components/app_cards/property_card/h_card/h_card_item_builder.dart';
import 'package:dallal_proj/core/constants/wid_lists.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class CardGridView extends StatelessWidget {
  final List<ShowDetailsEntity> items;
  final Widget Function(ShowDetailsEntity card, int index)? itemBuilder;
  final int selectedIndex;

  const CardGridView({
    super.key,
    required this.selectedIndex,
    required this.items,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: ValueKey<int>(items.hashCode),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 1),
      gridDelegate: CLwid.kGridDelegate(context),
      itemCount: items.length,

      itemBuilder: (context, index) {
        final card = items[index];
        // if (card.status != true) return const SizedBox();
        return itemBuilder?.call(card, index) ??
            HCardItemBuilder(
              advsListItem: card,
              isMyAdvScreen: (selectedIndex == 0),
            );
      },
    );
  }
}
