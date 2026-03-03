import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_refused_body.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:flutter/material.dart';

class AdvRefusedPage extends StatelessWidget {
  const AdvRefusedPage({super.key, required this.detailsEntity});
  final ShowDetailsEntity detailsEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showBackButton: true),
      body: PagePadding(
        fract: 0.07,
        child: AdvRefusedBody(detailsEntity: detailsEntity),
      ),
    );
  }
}
