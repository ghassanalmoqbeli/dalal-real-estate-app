import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/features/verify_msg_page/presentation/views/widgets/verify_msg_body.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class VerifyMsgPage extends StatelessWidget {
  const VerifyMsgPage({super.key, required this.vMsgModel});
  final VerifyMsgViewModel vMsgModel;

  @override
  Widget build(BuildContext context) {
    return UnfocusOntap(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: PagePadding(child: VerifyMsgBody(vMsgModel: vMsgModel)),
      ),
    );
  }
}
