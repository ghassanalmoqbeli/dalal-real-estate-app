import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class BSFormHolder extends StatelessWidget {
  const BSFormHolder({super.key, required this.form});
  final Widget form;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 24.0,
        left: 24.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: kTransP,
      child: SingleChildScrollView(
        child: SizedBox(
          width: Funcs.respWidth(fract: 0.88334, context: context),
          child: form,
        ),
      ),
    );
  }
}
