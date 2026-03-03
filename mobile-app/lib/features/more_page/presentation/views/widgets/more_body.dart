import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/large_form.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/small_form.dart';
import 'package:flutter/material.dart';

class MoreBody extends StatelessWidget {
  const MoreBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(),
        const Spacer(flex: 2),
        const SmallForm(),
        SizedBox(height: Funcs.respHieght(fract: 0.06, context: context)),
        const LargeForm(),
        const Spacer(flex: 4),
      ],
    );
  }
}
