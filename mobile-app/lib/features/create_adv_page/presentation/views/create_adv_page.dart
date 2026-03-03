import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/create_adv_body.dart';
import 'package:flutter/material.dart';

class CreateAdvPage extends StatelessWidget {
  const CreateAdvPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return UnfocusOntap(
      child: Scaffold(
        appBar: CustomAppBar(showBackButton: true, title: title),
        body: CrAdvBody(title: title),
      ),
    );
  }
}
