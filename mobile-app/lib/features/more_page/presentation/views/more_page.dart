import 'package:dallal_proj/features/more_page/presentation/views/more_loadable_body_builder.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteF5,
      appBar: const CustomAppBar(title: kMoreP, showBackButton: false),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Funcs.respWidth(fract: 0.06, context: context),
        ),
        child: const MoreLoadableBodyBuilder(),
      ),
    );
  }
}
