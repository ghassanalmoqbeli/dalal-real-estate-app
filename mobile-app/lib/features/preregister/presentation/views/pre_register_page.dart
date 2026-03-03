import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/pre_register_body.dart';

class PreRegisterPage extends StatelessWidget {
  const PreRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Funcs.respWidth(fract: 0.072, context: context),
        ),
        child: const PreRegisterBody(),
      ),
    );
  }
}
