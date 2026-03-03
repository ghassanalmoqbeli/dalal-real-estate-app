// pages/edit_adv_info_page.dart
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/edit_adv_info_body.dart';
import 'package:flutter/material.dart';

class EditAdvInfoPage extends StatelessWidget {
  final ShowDetailsEntity detailsEntity;

  const EditAdvInfoPage({super.key, required this.detailsEntity});

  @override
  Widget build(BuildContext context) {
    return UnfocusOntap(
      child: Scaffold(
        appBar: CustomAppBar(
          showBackButton: true,
          title: 'تعديل إعلان - ${detailsEntity.sectionDet}',
        ),
        body: EditAdvBody(detailsEntity: detailsEntity),
      ),
    );
  }
}
