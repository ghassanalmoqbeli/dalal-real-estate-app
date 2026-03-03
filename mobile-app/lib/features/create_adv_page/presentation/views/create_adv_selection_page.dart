import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/constants/mock_models.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/create_adv_selection_body.dart';

class CreateAdvSelectionPage extends StatelessWidget {
  const CreateAdvSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: kCreateAdv, showBackButton: false),
      body: Center(
        child: SizedBox(
          width: Funcs.respWidth(fract: 0.88, context: context),
          child: const CreateAdvSelectionBody(
            topLCell: kCrAdvCardHouse,
            topRCell: kCrAdvCardApt,
            btmLCell: kCrAdvCardStore,
            btmRCell: kCrAdvCardGrnd,
          ),
        ),
      ),
    );
  }
}
