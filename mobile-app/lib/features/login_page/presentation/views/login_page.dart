import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/features/login_page/presentation/views/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const UnfocusOntap(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(title: kLogin),
        body: PagePadding(child: LoginBody()),
      ),
    );
  }
}
