import 'package:dallal_proj/core/widgets/symmetric_pads/cvp_item.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_text_widgets/all_props_text_holder.dart';
import 'package:flutter/material.dart';

class AllPropsTextWid extends StatelessWidget {
  const AllPropsTextWid({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [CvpItem(tFract: 0.0365, child: AllPropsTextHolder())],
      ),
    );
  }
}
