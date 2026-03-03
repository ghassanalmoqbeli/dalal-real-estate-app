import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_body_items/adv_details_body_titled_item.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/desc_form.dart';
import 'package:flutter/material.dart';

class FDescBox extends StatelessWidget {
  const FDescBox({super.key, required this.detailsEntity});

  final ShowDetailsEntity detailsEntity;

  @override
  Widget build(BuildContext context) {
    return AdvDBTitledItem(
      title: kAdvDets,
      child: DescForm(detailsEntity: detailsEntity),
    );
  }
}
