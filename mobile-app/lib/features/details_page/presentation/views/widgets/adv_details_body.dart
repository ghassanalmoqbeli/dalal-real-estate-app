import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_body_items/adv_details_body_form.dart';
import 'package:flutter/material.dart';

class AdvDetailsBody extends StatelessWidget {
  const AdvDetailsBody({super.key, required this.detailsEntity});
  final ShowDetailsEntity detailsEntity;

  @override
  Widget build(BuildContext context) {
    final bool isPended = (detailsEntity.isMine && detailsEntity.isPended);

    return SingleChildScrollView(
      child: AdvDetailsBodyForm(
        detailsEntity: detailsEntity,
        isPended: isPended,
      ),
    );
  }
}
