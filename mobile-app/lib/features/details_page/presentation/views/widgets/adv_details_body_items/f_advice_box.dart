import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_body_items/adv_advise_section.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_body_items/adv_details_body_titled_item.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class FAdviceBox extends StatelessWidget {
  const FAdviceBox({super.key, required this.advices});
  final OptionsListModel advices;
  @override
  Widget build(BuildContext context) {
    return AdvDBTitledItem(
      title: advices.title,
      child: AdvAdviseSection(
        btmSpacing: 25,
        style: FStyles.s14W4,
        advices: advices.options,
      ),
    );
  }
}
