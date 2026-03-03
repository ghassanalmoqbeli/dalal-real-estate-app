import 'package:dallal_proj/features/featuring_adv_page/presentation/views/featuring_adv_loadable_body_builder.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:flutter/material.dart';

class FeaturingAdvPage extends StatelessWidget {
  const FeaturingAdvPage({super.key, required this.adID});
  final String adID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: PagePadding(
        fract: 0.025,
        child: FeaturingAdvLoadableBodyBuilder(adID: adID),
      ),
    );
    // );
  }
}
