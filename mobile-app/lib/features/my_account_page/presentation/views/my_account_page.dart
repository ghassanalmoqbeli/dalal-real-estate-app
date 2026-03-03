import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/my_account_body_builder.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: kMyAccP, showBackButton: false),
      body: PagePadding(fract: 0.05, child: MyAccountBodyBuilder()),
    );
  }
}
