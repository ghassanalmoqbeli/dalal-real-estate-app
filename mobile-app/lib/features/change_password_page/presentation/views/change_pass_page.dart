import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/features/change_password_page/presentation/views/change_pasword_loadable_budy_builder.dart';
import 'package:flutter/material.dart';

class ChangePassPage extends StatelessWidget {
  const ChangePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const UnfocusOntap(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: PagePadding(child: ChangePasswordLoadablePageBodyBuilder()),
      ),
    );
  }
}
