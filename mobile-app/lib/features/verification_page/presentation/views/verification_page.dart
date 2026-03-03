import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/features/verification_page/presentation/views/widgets/verification_body.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: PagePadding(child: VerificationBody()),
    );
  }
}
