import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/register_body.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const UnfocusOntap(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(title: kCreateAccount),
        body: PagePadding(child: RegisterBody()),
      ),
    );
  }
}
