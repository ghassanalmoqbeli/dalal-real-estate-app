import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/features/reset_password_page/presentation/views/widgets/reset_pass_body.dart';
import 'package:flutter/material.dart';

class ResetPassPage extends StatelessWidget {
  const ResetPassPage({super.key, required this.phone});
  final String phone;

  @override
  Widget build(BuildContext context) {
    return UnfocusOntap(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: PagePadding(child: ResetPasswordBody(phone: phone)),
      ),
    );
  }
}
