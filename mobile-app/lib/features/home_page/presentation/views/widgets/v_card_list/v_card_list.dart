import 'package:dallal_proj/core/components/app_cards/property_card/v_card/v_card_item_builder.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/filter_list_entity.dart';
import 'package:flutter/material.dart';

class VCardList extends StatelessWidget {
  const VCardList({super.key, required this.detailsEntity});
  final List<ShowDetailsEntity> detailsEntity;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: detailsEntity.length,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: VCardItemProvider(cardModel: detailsEntity[index]),
          ),
    );
  }
}

class FilterVCardList extends StatelessWidget {
  const FilterVCardList({super.key, required this.detailsEntity});
  final FilterListEntity detailsEntity;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: detailsEntity.advs.length,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: VCardItemProvider(cardModel: detailsEntity.advs[index]),
          ),
    );
  }
}
